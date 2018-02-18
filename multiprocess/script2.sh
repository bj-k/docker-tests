echo "this is script 2 with param $1"
if [ $1 ] && [ $1 = 'fail' ]
then
  echo "Fail..."
  exit 1
else
  echo "Succeed..."
  exit 0
fi
