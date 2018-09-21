
;;; package --- Summary
;;; Commentary:
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;; Code:
(package-initialize)
(setq default-directory "~/Users/lyu/Documents/emacs_info")
(require 'package)
(package-initialize)
;;(add-to-list 'package-archives
;;	      '("melpa-stable" . "http://stable.melpa.org/packages/")t)
(add-to-list 'package-archives
	      '("melpa" . "http://melpa.org/packages/")t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;(set-frame-parameter (selected-frame) 'alpha '(85 50))
;;(add-to-list 'default-frame-alist '(alpha 85 50))

;; enable elpy as default
;;(elpy-enable)

;; enable ido as default
;;(require 'ido)
;;(ido-mode t)

;; enable Helm as default
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(defun spacemacs//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))


(add-hook 'helm-minibuffer-set-up-hook
          'spacemacs//helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(helm-mode 1)

;;flymd
(require 'flymd)
(defun my-flymd-browser-function (url)
  (let ((process-environment (browse-url-process-environment)))
    (apply 'start-process
           (concat "firefox " url)
           nil
           "open"
           (list "-a" "Firefox.app" url))))
(setq flymd-browser-open-function 'my-flymd-browser-function)



;; modify highlight-indentation
;;(require 'highlight-indentation)
;;(set-face-background 'highlight-indentation-face "#e3e3d3")
;;(set-face-background 'highlight-indentation-current-column-face "#c3b3b3")

;; modify highlight-indent-guides
;;(add-to-list 'load-path "~/Users/lyu/Documents/emacs_info/.emacs.d/highlight-indent-guides.el")
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'character)
(setq highlight-indent-guides-character ?|)
(setq highlight-indent-guides-auto-odd-face-perc 15)
(setq highlight-indent-guides-auto-even-face-perc 15)
(setq highlight-indent-guides-auto-character-face-perc 20)


;; CC mode
(setq-default c-basic-offset 4)

;;elpy
(elpy-enable)
;;(setq python-shell-interpreter "/Users/lyu/anaconda3/bin/jupyter"
;;      python-shell-interpreter-args "console --simple-prompt")
(setq python-shell-interpreter "/Users/lyu/anaconda3/bin/ipython"
      python-shell-interpreter-args "-i --simple-prompt")

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)


;; enable autopep8
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; ein
(require 'ein)
(require 'ein-loaddefs)
(require 'ein-notebook)
(require 'ein-subpackages)

;; Enable transient mark mode
(transient-mark-mode 1)
;; enable org
(require 'org)
;; Make org-mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen

;; Fly Spell
;;(add-to-list 'load-path "c:/Users/lyu/AppData/Roaming/.emacs.d/flyspell.el")
(add-to-list 'load-path "/Users/lyu/Documents/emacs_info/.emacs.d/flyspell.el")
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))


;; Slime
;;(setq inferior-lisp-program (executable-find "sbcl"))


(provide '.emacs)

;;; .emacs ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("77bd459212c0176bdf63c1904c4ba20fce015f730f0343776a1a14432de80990" "7feeed063855b06836e0262f77f5c6d3f415159a98a9676d549bfeb6c49637c4" "c1fb68aa00235766461c7e31ecfc759aa2dd905899ae6d95097061faeb72f9ee" default)))
 '(package-selected-packages
   (quote
    (slime ein flycheck jedi elpy highlight-indent-guides highlight-indentation helm))))
