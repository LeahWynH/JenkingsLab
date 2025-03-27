Pipeline{
    Agent any
        Stages{
            Stage (“Prep”){
                Options {timeout or allowfailoure}
                    Step {
                        sh 'docker rm -vf $(docker ps -a -q)'
                        sh 'docker rmi -f $(docker images -a -q)'
                        sh 'docker builder prune --all --force'
                    }
                }
            Stage (“CreateNetwrok”){
                Options {timeout or allowfailoure}
                    Step {
                        sh 'docker network create lab9-network || true'
                    }
                }
            Stage (“CreateVolumes”){
                    Step {
                        sh 'docker volume create lab9vol'
                    }
                }
            Stage (“Build”){
                    Step {
                        sh 'docker build -t flaskapplab9 ./flask-app'
                        sh 'docker build -t sqllab9 ./db'
                    }
            }
            Stage (“Run”){
                    Step {
                        sh 'docker run -d --network lab9-network --name mysql --mount type=volume,source=lab9vol,target=/var/lib/mysql sqllab9'
                        sh 'docker run -d -e MYSQL_ROOT_PASSWORD="password" --network lab9-network --name flask-app flaskapplab9'
                        sh 'docker run -d -p 80:80 --network lab9-network --name nginxlab9container --mount type=bind,source=$(pwd)/nginx/nginx.conf,target=/etc/nginx/nginx.conf nginx'
                    }
            }
            Stage (“Check”){
                Script{
                        sh 'docker ps -a'
                    }
            }
        }
    }

