pipeline{
    agent any

        stages{
            stage (“Prep”){
                    steps {
                        sh 'docker rm -vf $(docker ps -a -q) || true'
                        sh 'docker rmi -f $(docker images -a -q) || true'
                        sh 'docker builder prune --all --force'
                    }
                }
            stage (“CreateNetwrok”){
                    steps {
                        sh 'docker network create lab9-network || true'
                    }
                }
            stage (“CreateVolumes”){
                    steps {
                        sh 'docker volume create lab9vol'
                    }
                }
            stage (“Build”){
                    steps {
                        sh 'docker build -t flaskapplab9 ./flask-app'
                        sh 'docker build -t sqllab9 ./db'
                    }
            }
            stage (“Run”){
                    steps {
                        sh 'docker run -d --network lab9-network --name mysql --mount type=volume,source=lab9vol,target=/var/lib/mysql sqllab9'
                        sh 'docker run -d -e MYSQL_ROOT_PASSWORD="password" --network lab9-network --name flask-app flaskapplab9'
                        sh 'docker run -d -p 80:80 --network lab9-network --name nginxlab9container --mount type=bind,source=$(pwd)/nginx/nginx.conf,target=/etc/nginx/nginx.conf nginx'
                    }
            }
            stage (“Check”){
                steps{
                        sh 'docker ps -a'
                    }
            }
        }
    }

