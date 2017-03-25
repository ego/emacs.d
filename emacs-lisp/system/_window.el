;;

(use-package ace-window
	:doc "https://github.com/abo-abo/ace-window/wiki"
	:tag "window"
	:defer 1
	:bind (("M-p" . ace-window))
	:config
	(when (fboundp 'winner-mode)
      (winner-mode 1))

	(set-face-attribute 'aw-leading-char-face nil :foreground "deep sky blue" :weight 'bold :height 3.0)
	(set-face-attribute 'aw-mode-line-face nil :inherit 'mode-line-buffer-id :foreground "lawn green")
	(setq aw-keys   '(?a ?s ?d ?f ?j ?k ?l)
	    aw-dispatch-always t
	    aw-dispatch-alist
	    '((?x aw-delete-window     "Ace - Delete Window")
	      (?c aw-swap-window       "Ace - Swap Window")
	      (?n aw-flip-window)
	      (?v aw-split-window-vert "Ace - Split Vert Window")
	      (?h aw-split-window-horz "Ace - Split Horz Window")
	      (?m delete-other-windows "Ace - Maximize Window")
	      (?g delete-other-windows)
	      (?b balance-windows)
	      (?u winner-undo)
	      (?r winner-redo)))

	(when (package-installed-p 'hydra)
	(defhydra hydra-window-size (:color red)
	  "Windows size"
	  ("h" shrink-window-horizontally "shrink horizontal")
	  ("j" shrink-window "shrink vertical")
	  ("k" enlarge-window "enlarge vertical")
	  ("l" enlarge-window-horizontally "enlarge horizontal"))
	(defhydra hydra-window-frame (:color red)
	  "Frame"
	  ("f" make-frame "new frame")
	  ("x" delete-frame "delete frame"))
	(defhydra hydra-window-scroll (:color red)
	  "Scroll other window"
	  ("n" joe-scroll-other-window "scroll")
	  ("p" joe-scroll-other-window-down "scroll down"))
	(add-to-list 'aw-dispatch-alist '(?w hydra-window-size/body) t)
	(add-to-list 'aw-dispatch-alist '(?o hydra-window-scroll/body) t)
	(add-to-list 'aw-dispatch-alist '(?\; hydra-window-frame/body) t))
	(ace-window-display-mode t))


(provide '_window)
