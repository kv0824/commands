# curl command to upload file to Nexus 3
curl -w "%{http_code}"  -F "maven2.groupId=com.yourcompony" -F "maven2.artifactId=artifactId" -F "maven2.veon=0.0.0" -F "maven2.asset1=@/Users/me/2.zip" -F "maven2.asset1.extension=zip" -F "maven2.generate-pom=true" -u abauser:aba123 "https://nexus.com/service/rest/v1/components?repository=test"
