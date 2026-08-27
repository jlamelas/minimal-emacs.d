;;; init-ui.el --- Interface de usuario -*- no-byte-compile: t; lexical-binding: t -*-

;;; Commentary:

;; Neste ficheiro irán as configuracións da interface de usuario de Emacs.

;;; Code:

;; Theme
(use-package ef-themes
  :init (load-theme 'ef-elea-dark :no-confirm-loading))

;; Icons
(use-package nerd-icons
  :init
  (when (and (not (member "Symbols Nerd Font Mono" (font-family-list)))
             (window-system))
    (nerd-icons-install-fonts t)))

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package treemacs-nerd-icons
  :ensure t
  :after treemacs
  :config
  (treemacs-load-theme "nerd-icons"))

;; `Mode line'
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 35)
  (setq doom-modeline-bar-width 4)
  (setq doom-modeline-hud nil)
  (setq doom-modeline-window-width-limit fill-column)
  (setq doom-modeline-buffer-file-name-style 'truncate-upto-project)
  (setq doom-modeline-icon t)
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-buffer-modification-icon t)
  (setq doom-modeline-minor-modes nil)
  (setq doom-modeline-enable-word-count nil)
  (setq doom-modeline-buffer-encoding nil)
  (setq doom-modeline-indent-info nil)
  (setq doom-modeline-checker-simple t)
  (setq doom-modeline-vcs-max-length 12)
  (setq doom-modeline-lsp t))

;; Column number
(column-number-mode)

;; Line numbers
(use-package display-line-numbers
  :ensure nil
  :hook ((prog-mode conf-mode vue-mode) . display-line-numbers-mode)
  :init (setq display-line-numbers-width-start t))

;; Rainbow delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Shows the actual color background for hex codes (e.g., #ffffff)
(use-package rainbow-mode
  :hook (prog-mode . rainbow-mode))

(provide 'init-ui)

;;; init-ui.el ends here
