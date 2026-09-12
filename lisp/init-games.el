;;; init-games.el --- Games configurations -*- no-byte-compile: t ; lexical-binding: t; -*-

;;; Commentary:

;; Configurations for games in Emacs.

;;; Code:

;; solo-rpg
(use-package solo-rpg
  :ensure t
  :bind (("C-c r" . solo-rpg-menu)))

(provide 'init-games)

;;; init-games.el ends here
