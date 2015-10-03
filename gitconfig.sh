echo Setting up Git global configuration.
git config --global user.name  "Rajesh Raheja"
git config --global user.email "rajesh.raheja@gmail.com"
git config --global credential.helper 'cache --timeout=3600'
git config --global push.default simple
# git config --global http.proxy  $http_proxy
# git config --global https.proxy $https_proxy
# git config --global no.proxy    $no_proxy
git config --global --list
