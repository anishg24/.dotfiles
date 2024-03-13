perlmutter_pass () {
  echo -n 'bw master password: '
  read -s MASTER_PASS
  echo
  echo -n 'Copying passkey...'
  echo "$(echo $MASTER_PASS | bw get password iris.nersc.gov 2>/dev/null)$(echo $MASTER_PASS | bw get totp iris.nersc.gov 2>/dev/null)" | wl-copy 
  echo 'Done.' 
}

compiler_explorer () {
  docker run -d -p 10240:10240 --name compiler-explorer madduci/docker-compiler-explorer 
}

airplay_server () {
  # sudo ufw allow UxPlay

  uxplay -p 10000 -nh -n "serval" -restrict -allow 88:66:5A:76:32:F5 -allow C4:AC:AA:76:B7:80

  # sudo ufw deny UxPlay
}

zathura_md () {
  cat $1 | pandoc -f markdown -t pdf | zathura -
}

fooocus () {
  /home/anish/.conda/envs/fooocus/bin/python /home/anish/Tools/Fooocus/entry_with_update.py
}
