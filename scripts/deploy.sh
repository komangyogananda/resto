apt-get update -y
apt-get install -y nodejs
curl -L https://npmjs.org/install.sh | sh
npm install -g yarn
export CI_COMMIT=$(echo ${TRAVIS_COMMIT:0:8})
echo $CI_COMMIT
docker build -t $DOCKER_HUB_USERNAME/resto:$CI_COMMIT .
docker images
'which ssh-agent || (sudo apt-get update -y && sudo apt-get install -y openssh-client)'
eval $(ssh-agent -s)
ssh-add <(echo $SSH_PRIVATE_KEY | base64 -d)
mkdir -p ~/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
docker login -u $DOCKER_HUB_USERNAME -p $DOCKER_HUB_PASSWORD
docker push $DOCKER_HUB_USERNAME/resto:$CI_COMMIT
ssh $DEPLOYMENT_HOST "docker pull $DOCKER_HUB_USERNAME/resto:$CI_COMMIT"
ssh $DEPLOYMENT_HOST "docker run --name kulguy-resto -d -p 9024:3000 $DOCKER_HUB_USERNAME/resto:$CI_COMMIT --binding=0.0.0.0"
