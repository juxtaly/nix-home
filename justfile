default: hm-switch

hm-switch:
  home-manager switch
pull-lazyvim:
  git subtree pull --prefix support/lazyvim https://github.com/atriw/lazyvim main

push-lazyvim:
  git subtree push --prefix support/lazyvim https://github.com/atriw/lazyvim main
