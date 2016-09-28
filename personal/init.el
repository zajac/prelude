(prelude-require-packages '(neotree))

(setq prelude-guru nil)


(prelude-require-package 'rainbow-delimiters)

(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)

(prelude-require-package 'paredit)
(add-hook 'emacs-lisp-mode-hook #'paredit-mode)
(add-hook 'clojure-mode-hook #'paredit-mode)
(add-hook 'helm-swoop-mode-hook #'paredit-mode)
(add-hook 'cider-repl-mode-hook #'paredit-mode)

;;;;;;;;;;;;;;; HELM ;;;;;;;;;;;;;;;;;;;

(prelude-require-packages '(helm helm-swoop helm-projectile))
;; http://tuhdo.github.io/helm-intro.html
;; https://github.com/ShingoFukuyama/helm-swoop

(with-eval-after-load 'helm
  (helm-mode 1)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
  )

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "s-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x f") 'helm-projectile)
(global-set-key (kbd "C-x C-r") 'helm-resume)

(setq helm-M-x-fuzzy-match t)
(setq helm-split-window-in-side-p nil)
(setq helm-split-window-default-side 'other)

(global-set-key (kbd "M-i") 'helm-swoop)

(with-eval-after-load 'helm-swoop
  (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)); From helm-swoop to helm-multi-swoop-all

(with-eval-after-load 'isearch
  (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)); When doing isearch, hand the word over to helm-swoop

(setq helm-swoop-split-direction 'split-window-horizontally)


(setq projectile-indexing-method 'alien)
(setq projectile-enable-caching t)

(setq helm-follow-mode-persistent t)
(setq helm-ag-use-temp-buffer t)

(prelude-require-packages '(ag helm-ag))

(global-set-key (kbd "M-I") 'helm-projectile-ag)

;;;;;;;;;;;;;;;;;; CIDER ;;;;;;;;;;;;;;;

(prelude-require-packages '(cider eldoc))

(setq cider-prompt-for-symbol nil) ; try to jump to symbol under cursor without minibuffer prompt
(setq cider-repl-use-pretty-printing t) ; use pretty print in repl
(setq cider-prompt-save-file-on-load 'always-save) ; when reloading file just save without prompting
(setq cider-font-lock-dynamically '(macro core function var)) ; colorize usages of functions and variables from any namespace
(setq cider-repl-display-help-banner nil)
;;;;;;;;;;;;;;;;

(prelude-require-packages '(company flx company-flx))
 (global-company-mode)
 (add-hook 'cider-repl-mode-hook #'company-mode)
 (add-hook 'cider-mode-hook #'company-mode)

(with-eval-after-load 'company
   (company-flx-mode t)
   (setq company-flx-limit 15))

 (setq company-idle-delay nil) ; never start completions automatically
 (global-set-key (kbd "TAB") #'company-indent-or-complete-common)

;;;;;;;;;; BUFFER-MOVE ;;;;;;;;;;;;;;;;;

(prelude-require-package 'buffer-move)
(global-set-key (kbd "<C-s-up>")     #'buf-move-up)
(global-set-key (kbd "<C-s-down>")   #'buf-move-down)
(global-set-key (kbd "<C-s-left>")   #'buf-move-left)
(global-set-key (kbd "<C-s-right>")  #'buf-move-right)

;;;;;;;;;;; GLOBALS ;;;;;;;;;;;;;;;;;;;

(define-key global-map [home] 'beginning-of-line)
(define-key global-map [end] 'end-of-line)

(global-set-key (kbd "<M-c M-p>") #'cider-eval-print-last-sexp)
(global-set-key (kbd "M-k") #'paredit-copy-as-kill)

(set-default 'truncate-lines t)
(setq truncate-lines t)

(setq scroll-margin 10)

(defun gcm-scroll-down () (interactive) (scroll-up 1))
(defun gcm-scroll-up () (interactive) (scroll-down 1))

(global-set-key (kbd "<s-up>") 'gcm-scroll-up)
(global-set-key (kbd "<s-down>") 'gcm-scroll-down)

;; do not show scrollbars in windowed version
(if (display-graphic-p)
    (scroll-bar-mode -1))

(setq vc-follow-symlinks t)

(load-theme 'zenburn t)

(if (not (display-graphic-p))
    (progn
      ;; disable current line highlight
      (global-hl-line-mode 0)

      ;; i like my terminal transparent, but background other than black makes it difficult to read
      (add-to-list 'default-frame-alist '(background-color . "black"))

      ;; i have no idea why i should change custom theme, but otherwise terminal's background flashes on opening from zenburn's grey to default black
      (with-eval-after-load "zenburn-theme"
        (zenburn-with-color-variables
          (custom-theme-set-faces 'zenburn `(default ((t (:foreground, zenburn-fg :background, "black")))))))))

(when (window-system)
  (set-default-font "Fira Code"))

(let ((alist '(
;;               (33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
;;               (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
;;               (36 . ".\\(?:>\\)")
;;               (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
;;               (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
;;               (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
;;               (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
;;               (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
;;               (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
;;               (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
;;               (48 . ".\\(?:x[a-zA-Z]\\)")
;;               (58 . ".\\(?:::\\|[:=]\\)")
;;               (59 . ".\\(?:;;\\|;\\)")

;;               (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
;;               (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
;;               (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
;;               (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
;;               (91 . ".\\(?:]\\)")
               
;;               (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
;;               (94 . ".\\(?:=\\)")
;;               (119 . ".\\(?:ww\\)")
;;               (123 . ".\\(?:-\\)")
;;               (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
;;               (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
               )
             ))
  (dolist (char-regexp alist)
    (set-char-table-range composition-function-table (car char-regexp)
                          `([,(cdr char-regexp) 0 font-shape-gstring]))))
(setq-default cursor-type 'bar)



(global-set-key (kbd "C--") 'undo)
(global-set-key (kbd "M-c") 'paredit-copy-as-kill)
(global-set-key "\M-p" 'cider-eval-print-last-sexp)
(global-set-key "\M-n" 'gcm-scroll-down)


(defun pretty-lambda ()
  "make some word or string show as pretty Unicode symbols"
  (setq prettify-symbols-alist
        '(
          ("fn" . 955) ; λ
          
          )))

(add-hook 'clojure-mode-hook 'pretty-lambda)
(global-prettify-symbols-mode 1)
