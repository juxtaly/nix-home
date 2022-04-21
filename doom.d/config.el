;;; .doom.d/config.el --- config
;;; Commentary:

;;; Code:
;; Setting the font.
(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 18))

;; Setting the theme.
(setq doom-theme 'doom-one)


(add-hook! 'emacs-startup-hook #'toggle-frame-fullscreen)

(after! lsp-mode
  (advice-remove #'lsp #'+lsp-dont-prompt-to-install-servers-maybe-a))

(setq evil-escape-key-sequence "kj")

(use-package! smooth-scrolling
  :config
  (smooth-scrolling-mode))

;; Setting wsl default browser.
(when (and (eq system-type 'gnu/linux)
           (string-match
            "Linux.*Microsoft.*Linux"
            (shell-command-to-string "uname -a")))
  (setq
   browse-url-generic-program  "/mnt/c/Windows/System32/cmd.exe"
   browse-url-generic-args     '("/c" "start")
   browse-url-browser-function #'browse-url-generic))

(provide 'config)
;;; config.el ends here
