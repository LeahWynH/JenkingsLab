Pipeline{
    Agent any
        Stages{
            Stage (“Prep”){
                Options {timeout or allowfailoure}
                    Step {
                        Sh 'docker rm -vf $(docker ps -a -q)'
                        Sh 'docker rmi -f $(docker images -a -q)'
                        Sh 'docker builder prune --all --force'
                    }
                }
            Stage (“Create Netwrok”){
                Options {timeout or allowfailoure}
                    Step {
                        Sh 'docker network create lab9-network || true'
                    }
                }
            Stage (“Create Volumes”){
                    Step {
                        Sh 'docker volume create lab9vol'
                    }
                }
            Stage (“Build”){
                    Step {
                        Sh 'docker build -t flaskapplab9 ./flask-app'
                        Sh 'docker build -t sqllab9 ./db'
                    }
            }
            Stage (“Run”){
                    Step {
                        Sh 'docker run -d --network lab9-network --name mysql --mount type=volume,source=lab9vol,target=/var/lib/mysql sqllab9'
                        Sh 'docker run -d -e MYSQL_ROOT_PASSWORD="password" --network lab9-network --name flask-app flaskapplab9'
                        Sh 'docker run -d -p 80:80 --network lab9-network --name nginxlab9container --mount type=bind,source=$(pwd)/nginx/nginx.conf,target=/etc/nginx/nginx.conf nginx'
                    }
            }
            Stage (“Check”){
                Script{
                        Sh 'docker ps -a'
                    }
            }
        }
    }

