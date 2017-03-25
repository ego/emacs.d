;;

(use-package ido-describe-bindings
  :doc "Мы не используем этот https://github.com/larkery/ido-describe-prefix-bindings.el
   хотя автор ido-grid-mode советует. Он плохо работает."
  :tag "key"
  :hot-key "M-x ido-describe-bindings")

(use-package ido-describe-prefix-bindings
  :ensure f
  :demand
  :bind ("M-X" . ido-describe-mode-bindings)
  :config
    (ido-describe-prefix-bindings-mode 1))

;; Enable which-key + guide-key
(use-package which-key
  :doc "https://github.com/justbur/emacs-which-key
   Позволяет увидеть какие функции закреплены за комбинациями клавиш.
   Достаточно нажать комбинацию и подождать чуть-чуть."
  :tag "key"
  :hot-key "C-h | C-h n"
  :init
  	(setq which-key-show-next-page t)
  	(setq which-key-add-column-padding 0)
  	(setq which-key-unicode-correction 3)
  	(setq which-key-show-remaining-keys t)
  :config
  	(which-key-mode +1)
  	;; (which-key-setup-side-window-right-bottom)
  	;; (which-key-setup-side-window-right)         ;; Окно справа
    ;; (which-key-setup-side-window-bottom)        ;; По умолчанию
    ;; (which-key-setup-minibuffer)                ;; Только в минибуфере
    (which-key-enable-god-mode-support t))

(use-package guide-key
  :doc "https://github.com/kai2nenobu/guide-key
   like which-key"
  :tag "key"
  :init (setq ;; guide-key/popup-window-position "top"
  			  guide-key/guide-key-sequence t
  			  guide-key/highlight-command-regexp
			      '("rectangle"
			        ("register" . font-lock-type-face)
			        ("bookmark" . "hot pink"))
  			  ; guide-key/guide-key-sequence '("shift f5")
  			  )
  :config 
  	(guide-key-mode 1)
  	(guide-key/key-chord-hack-on)
	(setq guide-key/recursive-key-sequence-flag t)
	(setq guide-key/guide-key-sequence
		  '("C-x" "C-c" "<key-chord>"
        	(org-mode "C-c C-x")
        	(outline-minor-mode "C-c @"))))

(use-package free-keys
  :doc "https://github.com/Fuco1/free-keys"
  :tag "help key bindings"
  :ensure t
  :config
  (bind-key "C-h C-k" 'free-keys))

(use-package keyfreq
  :doc "keyfreq-show to see how many times you used a command.
  https://github.com/dacap/keyfreq"
  :hot-key "M-x keyfreq-show"
  :ensure t
  :init
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

(provide '_utils)
