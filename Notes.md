# Complete CI-CD pipeline for spring pet clinic

* Launch an Ec2 instance (t2.micro)
* Install java and jenkins by using below steps

```
sudo apt-get update
sudo apt-get install openjdk-17-jdk -y
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
```
* Set password for jenkins by using ``passwd jenkins``
* Add the jenkins user into the sudoers file ``jenkins ALL=(ALL:ALL) NOPASSWD:ALL
* su jenkins


* Install docker by using below steps in the jenkins user
```
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo usermod -aG docker ubuntu
#exit and relogin
docker info
# This command should not give any errors
```

* Install awscli by using command `` sudo apt install awscli -y``
* ``aws configure`` enter the access key and secrete key from IAM credentials
* To check the configuration is done or not `` sudo aws s3 ls``
* docker login `` enter username and password``

* Create EKS cluster
* For install kubectl command is ``curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"`` ``sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl``
After install kubectl check ``kubectl version``


* Install eksctl

```
# for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

# (Optional) Verify checksum
curl -sL "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

sudo mv /tmp/eksctl /usr/local/bin
```
* Before cluster creation with yml file we have to do aws configure and kubectl configure must.
* before creating cluster we execute ssh-keygen ``ssh-keygen``
* Create a file called as cluster.yml with the following content
* paste below yaml file in this ``vi cluster.yaml``

```yaml
---
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: mycluster # we can give any name it is cluster name
  region: eu-west-3

nodeGroups:
  - name: basic # node group name
    instanceType: t2.medium
    desiredCapacity: 2
    volumeSize: 20
    ssh:
      allow: true # will use ~/.ssh/id_rsa.pub as the default ssh key
```
* Now execute the command ``eksctl create cluster -f cluster.yml``
* After creation execute ``kubectlget nodes``&&``kubectl get pods --all-namespaces``

For deleting the cluster eksctl delete cluster --name=<name> [--region=<region>]
example: ``eksctl delete cluster --name=mycluster --region=eu-west-3``




