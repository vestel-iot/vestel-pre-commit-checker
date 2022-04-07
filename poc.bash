LINES="^.*[^BUGFIX|^TASK]([A-Za-z0-9]{2}[A-Za-z0-9]+-[0-9]+|ARGE[0-9]{8})[ ]*:(.*)$"
ELINE="^(SOLUTION|SOL)[ ]*:(.*)$"

MSG="$(git log --max-count=1 --format=%B  31b34203d0777e27535f320883e986e835405d84)"


cat "$MSG" |  while IFS= read -r line
   do
           # Main Keywords
           if echo "$line" | grep -q -E "$LINES"; then
                   requiresSOLUTION=True
                   if test -z "$mainKEYWORD"; then
                           mainKEYWORD="ALL"
                   fi
           fi
           # Supplementary Keywords
           if echo "$line" | grep -q -E "$ELINES"; then
                   foundSOLUTION=True
                   echo "18"
           fi
           echo "19"
    done

   if test -z "$mainKEYWORD"; then
           # Various commit log checks
           printf 'Please provide only one of the following main keywords:\n'
           printf "BUGFIX,TASK"
           result=False
   elif test -n "$requiresSOLUTION"; then
           if test -z "$foundSOLUTION"; then
                   printf '\nPlease provide SOLUTION:<description>'
                   result=False
           else
                   result=True
           fi
   else
           result=True
   fi

   if [ "$result" = "False" ]; then
      echo "false"
   else
      echo "true"
   fi

