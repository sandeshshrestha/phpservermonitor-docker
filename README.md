# PHP Server Monitor Dockerfile
Dockerfile of `PHP Server Monitor`.
https://www.phpservermonitor.org/

```bash
docker run -p 80:80 sandeshshrestha/phpservermonitor
```

#### Requirement
- MySql Server
    - MySql Sever version 5.7
    - If MySql Server version is > 5.7 run it with `--default-authentication-plugin=mysql_native_password` flag.