# Create a Linux image by automating Github workflow file and deploy to AKS
# Overview
This template tests Github workflow automation which creates a Linux image pushed to a Container Registry.
The image is then deployed in AKS cluster using my-app yaml file. Resources such as AKS cluster and Container Registry 
are built using terraform in main.tf file.
