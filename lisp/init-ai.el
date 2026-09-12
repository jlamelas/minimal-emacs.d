;;; init-ai.el --- Configuracións para IA -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Commentary:

;; Configuracións para `gptel' e relacionados.

;;; Code:

;; gptel
(use-package gptel
  :custom
  (gptel-default-mode 'org-mode)
  (gptel-expert-commands t)
  (gptel-model 'gpt-4o)
  (gptel-api-key 'gptel-api-key-from-auth-source)  ;; Usar a función por defecto para obter a clave API
  :bind (("C-c j a c" . gptel)
         ("C-c j a s" . gptel-send)
         ("C-c j a m" . gptel-menu)
         ("M-n" . gptel-end-of-response))
  :config
  (require 'gptel-transient)

  ;; Ollama
  (gptel-make-ollama
      "ollama-compatible"
    :stream t
    :host "localhost:11434"
    :models (jla-get-ollama-models))
  ;; Gemini
  (gptel-make-gemini
      "google-gemini"
    :key 'gptel-api-key
    :stream t)
  ;; Copilot
  (setq gptel-backend (gptel-make-gh-copilot "Copilot"))
  ;; Github
  (gptel-make-openai "github-models"
    :host "models.inference.ai.azure.com"
    :endpoint "/chat/completions"
    :stream t
    :key 'gptel-api-key
    :models (append (jla-get-github-models) '("DeepSeek-R1"))))

;; gptel-agent
(use-package gptel-agent
  :config (gptel-agent-update))

;; gptel-annotate
(use-package gptel-annotate
  :vc (:url "https://github.com/karthink/gptel-annotate"
            :rev :newest)
  :after gptel)

;; gptel presets collection
(use-package gptel-preset-collection
  :vc (:url "https://github.com/karthink/gptel-preset-collection"
            :rev :newest)
  :after gptel)

;; matcher
(use-package macher
  :custom
  ;; The org UI has structured conversations and nice content folding.
  (macher-action-buffer-ui 'org)

  :hook
  ;; Set up action buffer behavior to your liking.  Alternately, do
  ;; this more generally in your `gptel-mode-hook'.
  (macher-action-buffer-setup
   . (lambda ()
       ;; Auto-scroll responses.
       (setq-local window-point-insertion-type t)
       ;; Wrap lines.
       (visual-line-mode 1)))

  :config
  ;; Recommended - register macher tools and presets with gptel.
  (macher-install)

  ;; Recommended - enable macher infrastructure for tools/prompts in
  ;; any buffer.  (Actions and presets will still work without this.)
  (macher-enable)

  ;; Adjust buffer positioning to taste.
  ;; (add-to-list
  ;;  'display-buffer-alist
  ;;  '("\\*macher:.*\\*"
  ;;    (display-buffer-in-side-window)
  ;;    (side . bottom)))
  ;; (add-to-list
  ;;  'display-buffer-alist
  ;;  '("\\*macher-patch:.*\\*"
  ;;    (display-buffer-in-side-window)
  ;;    (side . right)))
  )

(use-package gptel
  :config
  ;; Optional - set up macher as soon as gptel is loaded.
  (require 'macher))

(provide 'init-ai)

;;; init-ai.el ends here
