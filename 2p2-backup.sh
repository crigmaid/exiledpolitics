#!/bin/bash -ux

num_pages=0 # default, indicates error if 0
output_file_name="yourthread"
thread_base_index="0"

print_usage() {
cat << EOF
Usage: $0 (-h|--help)
Usage: $0 -p <number of pages> -t <thread base directory>

Optional params: 
-n <output file name>
EOF

}

parse_args() {

    if [[ $# -eq 0 ]] 
    then
        print_usage
        exit 0
    fi

    while [[ $# -ge 1 ]]; do
        argv="$1"
        case $argv in
        -h|--help)
            print_usage
            exit 0
            ;;
        -p|--pages)
            num_pages=$2
            shift
            ;;
        -n|--name)
            output_file_name=$2
            shift
            ;;
        -t|--thread)
            thread_base_index=$2
            shift
            ;;
        --sklansky)
            echo "Matt Sklanksy is a functioning stillborn."
            exit 69
            ;;
        *)
            echo "Invalid parameter given to script"
            print_usage
            exit 1
            ;;
        esac
        shift
    done
}

parse_args $@
[[ $num_pages -lt 1 ]] && \
    echo "Please provide the desired number of pages from the thread." && \
    print_usage

[[ $thread_base_index == "0" ]] && \
  echo "Please provide the base index (first page) of the thread" && \
  print_usage

i=1
while [[ $i -le $num_pages ]]; do
    wget -b -O $output_file_name$i".html" \
      $thread_base_index"index"$i".html"
    i=$((i+1))
    sleep 1
done

