az login
$RG = "RG-PrincipalFIAPLins"
$myACR = "myacrleoss001"
$loc="West US"
az acr create --location $loc --sku standard --admin-enable true --resource-group $RG --name $myACR 
az acr login --name $myACR
az acr list --resource-group $RG --query "[].{acrLoginServer:loginServer}" --output table
docker tag besu:fiaptdc myacrleoss001.azurecr.io/besu:fiap2

docker images
docker push myacrleoss001.azurecr.io/besu:fiap2
az acr repository list --name $myACR --output table
az acr repository show-tags --name $myACR --repository azure-vote-front --output table


