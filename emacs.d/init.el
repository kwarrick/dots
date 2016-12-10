;; Packages
;; ------------------------------------------------------------------------------
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages
  '(
    evil
    evil-leader
    ))
;    company
;    projectile
;    helm
;    helm-projectile
;    flycheck
;    magit))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

; Evil
(require 'evil)
(require 'evil-leader)
(global-evil-leader-mode)
(evil-mode 1)
(evil-leader/set-leader ",")
(setq evil-leader/in-all-states 1)
(evil-leader/set-key
  "." 'switch-to-prev-buffer
  "e" 'find-file
  "k" 'kill-buffer
  "w" 'save-buffer
  "o" 'delete-other-windows
  "b" 'helm-mini
  "x" 'helm-M-x)

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

; Projectile
; (projectile-global-mode)

; Helm
; (helm-mode 1)
; (setq helm-autoresize-mode t)
; (setq helm-buffers-fuzzy-matching t)

; (global-set-key (kbd "M-x") 'helm-M-x)
; (global-set-key (kbd "C-x b") 'helm-buffers-list)

; Helm-Projectile
; (setq projectile-completion-system 'helm)
; (helm-projectile-on)

; Company
; (add-hook 'after-init-hook 'global-company-mode)
 
; Flycheck
; (global-flycheck-mode)

(if (eq system-type 'darwin)
    (add-to-list 'my-packages 'exec-path-from-shell))


;; User Interface
;; ------------------------------------------------------------------------------
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)


(fset 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore)
(setq-default frame-title-format "%b (%f)")

(tool-bar-mode -1)
(menu-bar-mode -1)
(when (boundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

(show-paren-mode 1)
(column-number-mode 1)

(global-linum-mode 1)
(setq linum-format "%d ")

(setq create-lockfiles nil)
(setq make-backup-files nil)

; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
; (if (window-system)
;     (load-theme 'blackboard t)
;     (load-theme 'jbeans t))

;; Languages
;; ------------------------------------------------------------------------------
(setq python-shell-interpreter "ipython"
    python-shell-interpreter-args "-i")

