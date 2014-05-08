args=()
until [ -z "$1" ]; do
  case "$1" in
    -f|--folders) folders="$2"; shift 2 ;;
    -p|--prefix) prefix="$2"; shift 2 ;;
    -e|--extension) extension="$2"; shift 2 ;;
    --) shift ; break ;;
    -*) echo "invalid option $1" 1>&2 ; shift ;; # or, error and exit 1 just like getopt does
    *) args+=("$1") ; shift ;;
  esac
done

result=${PWD}
cd "$result"

for (( c=1; c<=$folders; c++ ))
do
  mkdir "file_$c"
done

declare -i big_count
big_count=0

declare -i loop_count
loop_count=0

for f in *.$extension
do
  x=${f%.$extension}
  y=${x#"$prefix"}
  z=`expr $y % $folders`

  if [ $loop_count == 0 ]
    then
      ((big_count++))
  fi

  ((loop_count++))
  #
  mv $f "$result/file_$loop_count/$big_count.$extension"

  loop_count=`expr $loop_count % $folders`
done
