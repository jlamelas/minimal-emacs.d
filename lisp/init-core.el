;;; init-core.el --- Configuracións centrais -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Comment:

;; Configuracións centrais de Emacs.

;;; Code

;; Native compilation enhances Emacs performance by converting Elisp code into
;; native machine code, resulting in faster execution and improved
;; responsiveness.
;;
;; Ensure adding the following compile-angel code at the very beginning
;; of your `~/.emacs.d/post-init.el` file, before all other packages.
(use-package compile-angel
  :ensure t
  :demand t
  :custom
  ;; Set `compile-angel-verbose` to nil to suppress output from compile-angel.
  ;; Drawback: The minibuffer will not display compile-angel's actions.
  (compile-angel-verbose t)

  :config
  ;; The following directive prevents compile-angel from compiling your init
  ;; files. If you choose to remove this push to `compile-angel-excluded-files'
  ;; and compile your pre/post-init files, ensure you understand the
  ;; implications and thoroughly test your code. For example, if you're using
  ;; `use-package', you'll need to explicitly add `(require 'use-package)` at
  ;; the top of your init file.
  (push "/init.el" compile-angel-excluded-files)
  (push "/early-init.el" compile-angel-excluded-files)
  (push "/pre-init.el" compile-angel-excluded-files)
  (push "/post-init.el" compile-angel-excluded-files)
  (push "/pre-early-init.el" compile-angel-excluded-files)
  (push "/post-early-init.el" compile-angel-excluded-files)
  (push "/lisp/init-utils.el" compile-angel-excluded-files)
  (push "/lisp/init-ui.el" compile-angel-excluded-files)
  (push "/lisp/init-core.el" compile-angel-excluded-files)

  ;; A local mode that compiles .el files whenever the user saves them.
  ;; (add-hook 'emacs-lisp-mode-hook #'compile-angel-on-save-local-mode)

  ;; A global mode that compiles .el files before they are loaded.
  (compile-angel-on-load-mode))

;; Auto-revert in Emacs is a feature that automatically updates the
;; contents of a buffer to reflect changes made to the underlying file
;; on disk.
(use-package autorevert
  :ensure nil
  :commands (auto-revert-mode global-auto-revert-mode)
  :hook
  (after-init . global-auto-revert-mode)
  :custom
  (auto-revert-interval 3)
  (auto-revert-remote-files nil)
  (auto-revert-use-notify t)
  (auto-revert-avoid-polling nil)
  (auto-revert-verbose t))

;; Recentf is an Emacs package that maintains a list of recently
;; accessed files, making it easier to reopen files you have worked on
;; recently.
(use-package recentf
  :ensure nil
  :commands (recentf-mode recentf-cleanup)
  :hook
  (after-init . recentf-mode)

  :custom
  (recentf-auto-cleanup (if (daemonp) 300 'never))
  (recentf-exclude
   (list "\\.tar$" "\\.tbz2$" "\\.tbz$" "\\.tgz$" "\\.bz2$"
         "\\.bz$" "\\.gz$" "\\.gzip$" "\\.xz$" "\\.zip$"
         "\\.7z$" "\\.rar$"
         "COMMIT_EDITMSG\\'"
         "\\.\\(?:gz\\|gif\\|svg\\|png\\|jpe?g\\|bmp\\|xpm\\)$"
         "-autoloads\\.el$" "autoload\\.el$"))

  :config
  ;; A cleanup depth of -90 ensures that `recentf-cleanup' runs before
  ;; `recentf-save-list', allowing stale entries to be removed before the list
  ;; is saved by `recentf-save-list', which is automatically added to
  ;; `kill-emacs-hook' by `recentf-mode'.
  (add-hook 'kill-emacs-hook #'recentf-cleanup -90))

;; savehist is an Emacs feature that preserves the minibuffer history between
;; sessions. It saves the history of inputs in the minibuffer, such as commands,
;; search strings, and other prompts, to a file. This allows users to retain
;; their minibuffer history across Emacs restarts.
(use-package savehist
  :ensure nil
  :commands (savehist-mode savehist-save)
  :hook
  (after-init . savehist-mode)
  :custom
  (savehist-autosave-interval 600)
  (savehist-additional-variables
   '(kill-ring                        ; clipboard
     register-alist                   ; macros
     mark-ring global-mark-ring       ; marks
     search-ring regexp-search-ring)))

;; save-place-mode enables Emacs to remember the last location within a file
;; upon reopening. This feature is particularly beneficial for resuming work at
;; the precise point where you previously left off.
(use-package saveplace
  :ensure nil
  :commands (save-place-mode save-place-local-mode)
  :hook
  (after-init . save-place-mode)
  :custom
  (save-place-limit 400))

;; Enable `auto-save-mode' to prevent data loss. Use `recover-file' or
;; `recover-session' to restore unsaved changes.
(setq auto-save-default t)

(setq auto-save-interval 300)
(setq auto-save-timeout 30)

;; The stripspace Emacs package provides stripspace-local-mode, a minor mode
;; that automatically removes trailing whitespace and blank lines at the end of
;; the buffer when saving.
(use-package stripspace
  :ensure t
  :commands stripspace-local-mode

  ;; Enable for prog-mode-hook, text-mode-hook, conf-mode-hook
  :hook ((prog-mode . stripspace-local-mode)
         (text-mode . stripspace-local-mode)
         (conf-mode . stripspace-local-mode))

  :custom
  ;; The `stripspace-only-if-initially-clean' option:
  ;; - nil to always delete trailing whitespace.
  ;; - Non-nil to only delete whitespace when the buffer is clean initially.
  ;; (The initial cleanliness check is performed when `stripspace-local-mode'
  ;; is enabled.)
  (stripspace-only-if-initially-clean nil)

  ;; Enabling `stripspace-restore-column' preserves the cursor's column position
  ;; even after stripping spaces. This is useful in scenarios where you add
  ;; extra spaces and then save the file. Although the spaces are removed in the
  ;; saved file, the cursor remains in the same position, ensuring a consistent
  ;; editing experience without affecting cursor placement.
  (stripspace-restore-column t))

;; This automates the process of updating installed packages
(use-package auto-package-update
  :ensure t
  :custom
  ;; Set the number of days between automatic updates.
  ;; Here, packages will only be updated if at least 7 days have passed
  ;; since the last successful update.
  (auto-package-update-interval 7)

  ;; Suppress display of the *auto-package-update results* buffer after updates.
  ;; This keeps the user interface clean and avoids unnecessary interruptions.
  (auto-package-update-hide-results t)

  ;; Automatically delete old package versions after updates to reduce disk
  ;; usage and keep the package directory clean. This prevents the accumulation
  ;; of outdated files in Emacs’s package directory, which consume
  ;; unnecessary disk space over time.
  (auto-package-update-delete-old-versions t)

  ;; Uncomment the following line to enable a confirmation prompt
  ;; before applying updates. This can be useful if you want manual control.
  ;; (auto-package-update-prompt-before-update t)

  :config
  ;; Run package updates automatically at startup, but only if the configured
  ;; interval has elapsed.
  (auto-package-update-maybe)

  ;; Schedule a background update attempt daily at 10:00 AM.
  ;; This uses Emacs' internal timer system. If Emacs is running at that time,
  ;; the update will be triggered. Otherwise, the update is skipped for that
  ;; day. Note that this scheduled update is independent of
  ;; `auto-package-update-maybe` and can be used as a complementary or
  ;; alternative mechanism.
  (auto-package-update-at-time "20:00"))

;; Helpful is an alternative to the built-in Emacs help that provides much more
;; contextual information.
(use-package helpful
  :ensure t
  :commands (helpful-callable
             helpful-variable
             helpful-key
             helpful-command
             helpful-at-point
             helpful-function)
  :bind
  ([remap describe-command] . helpful-command)
  ([remap describe-function] . helpful-callable)
  ([remap describe-key] . helpful-key)
  ([remap describe-symbol] . helpful-at-point)
  ([remap describe-variable] . helpful-variable)
  :custom
  (helpful-max-buffers 7))

;; Improve keyboard shortcut discoverability
(use-package which-key
  :config
  (which-key-mode)
  :custom
  (which-key-max-description-length 40)
  (which-key-lighter nil)
  (which-key-sort-order 'which-key-description-order))

;; Text mode settings
(use-package text-mode
  :ensure
  nil
  :hook
  (text-mode . visual-line-mode)
  :init
  (delete-selection-mode t)
  :custom
  (sentence-end-double-space nil)
  (scroll-error-top-bottom t)
  (save-interprogram-paste-before-kill t))

;; Check spelling with flyspell and hunspell
(use-package flyspell
  :custom
  (ispell-program-name "hunspell")
  (ispell-dictionary "gl_ES")
  ;;(flyspell-mark-duplications-flag nil) ;; Writegood mode does this
  (org-fold-core-style 'overlays) ;; Fix Org mode bug
  :config
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "gl_ES,es_ES,en_GB")
  :hook
  ((text-mode . flyspell-mode)
   ((prog-mode vue-mode) . flyspell-prog-mode))
  :bind
  (("C-c w s s" . ispell)
   ("C-;"       . flyspell-auto-correct-previous-word)))

;; FILE MANAGEMENT
(use-package dired
  :ensure
  nil
  :commands
  (dired dired-jump)
  :hook
  ((dired-mode . dired-hide-details-mode)
   (dired-mode . hl-line-mode))
  :custom
  (dired-listing-switches
   "-goah --group-directories-first --time-style=long-iso")
  (dired-dwim-target t)
  (delete-by-moving-to-trash t)
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  :init
  (put 'dired-find-alternate-file 'disabled nil))

;; Hide or display hidden files
(use-package dired
  :ensure nil
  :hook (dired-mode . dired-omit-mode)
  :bind (:map dired-mode-map
              ( "."     . dired-omit-mode))
  :custom (dired-omit-files "^\\.[a-zA-Z0-9]+"))

;; Dired subtree
(use-package dired-subtree
  :ensure t
  :after dired
  :bind
  ( :map dired-mode-map
    ("<tab>" . dired-subtree-toggle)
    ("TAB" . dired-subtree-toggle)
    ("<backtab>" . dired-subtree-remove)
    ("S-TAB" . dired-subtree-remove))
  :config
  (setq dired-subtree-use-backgrounds nil))

;; Dired image
(use-package image-dired
  :bind
  (("C-c w I" . image-dired))
  (:map image-dired-thumbnail-mode-map
        ("C-<right>" . image-dired-display-next)
        ("C-<left>"  . image-dired-display-previous)))

;; Trashed
(use-package trashed
  :ensure t
  :commands (trashed)
  :config
  (setq trashed-action-confirmer 'y-or-n-p)
  (setq trashed-use-header-line t)
  (setq trashed-sort-key '("Date deleted" . t))
  (setq trashed-date-format "%Y-%m-%d %H:%M:%S"))

;; Backup files
(setq-default backup-directory-alist
              `(("." . ,(expand-file-name "backups/" user-emacs-directory)))
              version-control t
              delete-old-versions t
              create-lockfiles nil)

;; Electric pair
(use-package elec-pair
  :hook (prog-mode . electric-pair-mode)
  :init (setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit))

;; Terminal emulator
;; Only GNU/Linux systems. Install this packages `apt install cmake libtool libtool-bin'
(when (eq system-type 'gnu/linux)

  (use-package vterm
    :commands vterm
    :custom
    (vterm-always-compile-module t)
    :config
    (setq vterm-shell "bash")
    (setq vterm-max-scrollback 10000))

  (use-package vterm-toggle
    :bind (
           :map global-map
           ("C-c v t" . 'vterm-toggle)
           ("C-c v c" . vterm-toggle-cd)
           :map vterm-mode-map
           ("C-<return>" . vterm-toggle-insert-cd)
           ("M-f". vterm-toggle-forward)
           ("M-b" . vterm-toggle-backward))))

;; imenu list
(use-package imenu-list
  :custom
  (imenu-list-focus-after-activation t)
  :bind
  (("C-." . imenu-list-smart-toggle)))

(provide 'init-core)

;;; init-core.el ends here
