;; General
;; --------------------------------------------------------------------

(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

(global-linum-mode t)

(show-paren-mode 1)
(setq show-paren-delay 0)

(setq create-lockfiles nil)
(setq make-backup-files nil)

(set-default 'truncate-lines t)

(defalias 'yes-or-no-p 'y-or-n-p)

(line-number-mode 1)
(column-number-mode 1)

(setq-default indent-tabs-mode nil)


;; Plugins
;; --------------------------------------------------------------------

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
             '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package general)

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (evil-leader/set-key
    "l" 'whitespace-mode
    "n" 'linum-mode
    "w" 'toggle-truncate-lines))

(use-package evil
  :ensure t
  :config
  (general-evil-setup)
  (evil-mode 1))

(use-package evil-commentary
  :ensure t
  :after (evil)
  :config
  (evil-commentary-mode))

(use-package evil-search-highlight-persist
  :ensure t
  :config
  (evil-leader/set-key "h" 'evil-search-highlight-persist-remove-all)
  (global-evil-search-highlight-persist t))

(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x b" . helm-buffers-list))
  :general
  (general-nmap "SPC b" 'helm-mini)
  :config
  (setq helm-quick-update t)
  (setq helm-bookmark-show-location t)
  (setq helm-buffers-fuzzy-matching t)
  (helm-autoresize-mode 1)
  (helm-mode 1))

(use-package helm-projectile
  :ensure t
  :after (helm projectile)
  :commands (helm-projectile)
  :general
  (general-nmap "SPC p" 'helm-projectile-switch-project)
  (general-nmap "SPC t" 'helm-projectile-find-file)
  :config
  (helm-projectile-on)
  (message "h-p"))

(use-package projectile
  :ensure t
  :defer t
  :bind-keymap
    ("C-c p" . projectile-command-map)
  :config
  (projectile-mode))

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.2)
  (define-key company-active-map [tab] 'company-complete)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (global-company-mode))

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

(use-package all-the-icons)
(use-package neotree
  :ensure t
  :config
  (evil-leader/set-key
   "t" 'neotree-toggle)
  (setq neo-smart-open t)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (add-hook 'neotree-mode-hook
    (lambda ()
        (setq-local linum-mode nil)
        (define-key evil-normal-state-local-map (kbd "C") 'neotree-change-root)
        (define-key evil-normal-state-local-map (kbd "r") 'neotree-refresh)
        (define-key evil-normal-state-local-map (kbd "s") 'neotree-enter-vertical-split)
        (define-key evil-normal-state-local-map (kbd "S") 'neotree-enter-horizontal-split)
        (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
        (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter))))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package rust-mode
  :mode "\\.rs\\'"
  :after flycheck
  :init
  (setq rust-format-on-save t)
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package racer
  :after (rust-mode flycheck)
  :config
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode))

(use-package flycheck-rust
  :after (flycheck rust-mode)
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package flycheck-clang-tidy
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-clang-tidy-setup))

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))
;; Appearance
;; --------------------------------------------------------------------

(menu-bar-mode 0)
(tool-bar-mode 0)
(toggle-scroll-bar -1)

(use-package base16-theme
  :config
  (load-theme 'base16-default-dark t))

(setq whitespace-display-mappings
    '(
      (space-mark 32 [183] [46])
      (newline-mark 10 [172 10])
      (tab-mark 9 [8227 9] [92 9])
      ))

(setq visible-bell nil
      ring-bell-function 'flash-mode-line)
(defun flash-mode-line ()
  (invert-face 'mode-line)
  (run-with-timer 0.1 nil #'invert-face 'mode-line))
