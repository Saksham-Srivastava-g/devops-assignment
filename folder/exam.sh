#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
NC="\e[0m"

add_users() {
    file=$1
    if [[ ! -f $file ]]; then
        echo -e "${RED}file not found, please give correct one${NC}"
        exit 1
    fi

    echo -e "${BLUE}Adding users from file...${NC}"
    while read -r user; do
        if id "$user" &>/dev/null; then
            echo -e "${YELLOW}$user already there, skipping${NC}"
        else
            sudo useradd -m "$user" && echo -e "${GREEN}User $user made successfully ${NC}" || echo -e "${RED}Failed $user${NC}"
        fi
    done < "$file"
}

setup_projects() {
    user=$1
    num=$2

    if [[ -z $user || -z $num ]]; then
        echo -e "${RED}ENTER CORRECT INPUT ${NC}"
        exit 1
    fi

    base="/home/$user/projects"
    sudo mkdir -p "$base"
    for ((i=1; i<=num; i++)); do
        p="$base/project$i"
        sudo mkdir -p "$p"
        echo "Project $i made by $user on $(date)" | sudo tee "$p/README.txt" >/dev/null
        sudo chmod 755 "$p"
        sudo chmod 640 "$p/README.txt"
        sudo chown -R "$user:$user" "$p"
    done
    echo -e "${GREEN}$num projects done for $user${NC}"
}


sys_report() {
    out=$1

    if [[ -z $out ]]; then
        echo -e "${RED}Please give an output file name${NC}"
        exit 1
    fi

    {
        echo "System Report - $(date)"
        echo "-------------------------"

        echo "Disk usage:"
        df -h
        echo ""

        echo "Memory info:"
        free -h
        echo ""

        echo "CPU info:"
        lscpu | grep 'Model name'
        echo ""

        echo "Top 5 memory-consuming processes:"
        ps aux --sort=-%mem | head -n 6
        echo ""

        echo "Top 5 CPU-consuming processes:"
        ps aux --sort=-%cpu | head -n 6
    } > "$out"

    echo -e "${GREEN}Report saved to $out${NC}"
}


process_manage() {
    user=$1
    act=$2

    case $act in
        list_zombies)
            echo -e "${BLUE}Zombie :${NC}"
            ps -eo pid,stat,comm,user | grep 'Z' || echo "no zombie found"
            ;;
        list_stopped)
            echo -e "${BLUE}Stopped :${NC}"
            ps -eo pid,stat,comm,user | grep 'T' || echo "no stopped found"
            ;;
        kill_zombies)
            echo -e "${YELLOW}Parrent can do that${NC}"
            ;;
        kill_stopped)
		echo -e "${YELLOW}killingstopped=$(ps -eo pid,stat,comm,user | grep 'T')
	.${NC}"
            for pid in $(ps -eo pid,stat | awk '$2 ~ /T/ {print $1}'); do
                sudo kill -9 "$pid" 2>/dev/null
            done
            echo -e "${GREEN}Stopped process killed done${NC}"
            ;;
        *)
            echo -e "${RED}invalid action, try list_zombies, list_stopped, kill_zombies, kill_stopped${NC}"
            ;;
    esac
}

perm_owner() {
    user=$1
    path=$2
    perm=$3
    owner=$4
    group=$5

    if [[ ! -d $path ]]; then
        echo -e "${RED}path not exist${NC}"
        exit 1
    fi

    sudo chmod -R "$perm" "$path"
    sudo chown -R "$owner:$group" "$path"

    echo -e "${GREEN}permission and owner updated for $path${NC}"
}

show_help() {
    echo -e "${BLUE}Usage:${NC}"
    echo "./sys_manager.sh add_users <file>"
    echo "./sys_manager.sh setup_projects <username> <count>"
    echo "./sys_manager.sh sys_report <outfile>"
    echo "./sys_manager.sh process_manage <username> <action>"
    echo "./sys_manager.sh perm_owner <user> <path> <perm> <owner> <group>"
    echo "./sys_manager.sh help"
}

case $2 in
    add_users) add_users "$2" ;;
    setup_projects) setup_projects "$2" "$3" ;;
    sys_report) sys_report "$2" ;;
    process_manage) process_manage "$2" "$3" ;;
    perm_owner) perm_owner "$2" "$3" "$4" "$5" "$6" ;;
    help|*) show_help ;;
esac
