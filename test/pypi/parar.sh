while read task; do 
  if [ "$task" ] ; then 
    echo Stopping task $task; 
    aws ecs stop-task --cluster Container-ECS-Cluster --task $task; 
  fi; 
done<<<"`aws ecs list-tasks --cluster Container-ECS-Cluster|grep "arn:aws"|awk -F'"' '{print $2}'|awk -F'/' '{print $NF}'`"
