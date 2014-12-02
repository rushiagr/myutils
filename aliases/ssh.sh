function ssh-fingerprint() {
  if [ -z $1 ]; then
      echo "usage: ssh-fingerprint <pub/priv key>"
      return
  else
      ssh-keygen -lf $1
  fi
}
