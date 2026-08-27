;;; init-dev.el --- Configuración para programación -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Commentary:

;; Configuracións para programación.

;;; Code

;; Magit
(use-package magit)

;; Tree-sitter in Emacs is an incremental parsing system introduced in Emacs 29
;; that provides precise, high-performance syntax highlighting. It supports a
;; broad set of programming languages, including Bash, C, C++, C#, CMake, CSS,
;; Dockerfile, Go, Java, JavaScript, JSON, Python, Rust, TOML, TypeScript, YAML,
;; Elisp, Lua, Markdown, and many others.
(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode)
  ;; Enhanced syntax highlighting
  (setq treesit-font-lock-level 4)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; Major mode remapping
(setq major-mode-remap-alist
      '((yaml-mode . yaml-ts-mode)
        (bash-mode . bash-ts-mode)
        (js-mode . js-ts-mode)
        (js2-mode . js-ts-mode)
        (js-base-mode . js-ts-mode)
        (typescript-mode . typescript-ts-mode)
        (json-mode . json-ts-mode)
        (css-mode . css-ts-mode)
        (python-mode . python-ts-mode)
        (tsx-mode . tsx-ts-mode)
        (jsx-mode . tsx-ts-mode)
        (java-mode . java-ts-mode)))

(provide 'init-dev)

;;; init-dev.el ends here
