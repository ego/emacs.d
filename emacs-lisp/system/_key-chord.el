;; key-chord

(use-package key-chord
  :doc "https://www.emacswiki.org/emacs/key-chord.el
   Одновременные комбинации клавиш без спец. клавиш. Последовательность не имеет значения."
  :tag "key hudra"
  :config (key-chord-mode 1))

(key-chord-define-global "dd" 'dired) 			 ;; global bindings
;; (key-chord-define c++-mode-map ";;"  "\C-e;") ;; bindings in mode


(provide '_key-chord)
