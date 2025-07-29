pipeline {
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    some-label: jenkins-kaniko
spec:
  serviceAccountName: jenkins-sa
  containers:
    - name: kaniko
      image: gcr.io/kaniko-project/executor:v1.16.0-debug
      imagePullPolicy: Always
      command:
        - sleep
      args:
        - 99d
    - name: git
      image: alpine/git
      command:
        - sleep
      args:
        - 99d
"""
    }
  }

  environment {
    ECR_REGISTRY = "518036921332.dkr.ecr.eu-central-1.amazonaws.com/lesson-7-ecr"
    IMAGE_NAME   = "app"
    IMAGE_TAG    = "v1.0.${BUILD_NUMBER}"

    COMMIT_EMAIL = "jenkins@localhost"
    COMMIT_NAME  = "jenkins"
    REPO_URL     = "https://github.com/cod3provider/woolf-microservice-project.git"
    REPO_BRANCH  = "lesson-8-9"
  }

  stages {
    stage('Build & Push Docker Image') {
      steps {
        container('kaniko') {
          sh '''
            /kaniko/executor \
              --context `pwd` \
              --dockerfile `pwd`/Dockerfile \
              --destination=$ECR_REGISTRY/$IMAGE_NAME:$IMAGE_TAG \
              --cache=true \
              --insecure \
              --skip-tls-verify
          '''
        }
      }
    }

    stage('Update Chart Tag in Git') {
      steps {
        container('git') {
          withCredentials([usernamePassword(credentialsId: 'github-token', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PAT')]) {
            sh '''
              git clone --depth 1 https://$GIT_USERNAME:$GIT_PAT@github.com/cod3provider/woolf-microservice-project.git
              cd my-microservice-project/charts/django-app

              sed -i "s/tag: .*/tag: $IMAGE_TAG/" values.yaml

              git config user.email "$COMMIT_EMAIL"
              git config user.name "$COMMIT_NAME"

              git add values.yaml
              git commit -m "Update image tag to $IMAGE_TAG"
              git push origin $REPO_BRANCH
            '''
          }
        }
      }
    }
  }
}