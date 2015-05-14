;; Diverse settings
;;(setq debug-on-error t)
;bummer;(defconst debian-emacs-flavor 'emacs21 "")
;bummer;(load "debian-startup")
;bummer;(debian-startup 'emacs21)
;bummer;(load "debian-changelog-mode")
;(gnuserv-start)

;(setq gnuserv-frame nil)
;(setq gnuserv-kill-quietly t)
;(server-force-delete)
;(setq server-use-tcp 1)
(server-start)
;(setq kill-ring-max 60)
;(setq mark-ring-max 40)
(setq kept-old-versions 1)
(setq kept-new-versions 2)
(setq debug-on-error nil)
(autoload 'archie "archie" "Archie interface" t)
(global-font-lock-mode t)
;(load "auto-show")
(load "completion")(initialize-completions)
(setq completion-ignored-extensions
      (append completion-ignored-extensions '(".so" ".ro" ".ao")))
(setq search-whitespace-regexp nil)

;; vfn
(setq wq '(lambda() (interactive) (save-buffer)))
;(setq delete-selection-mode t)

(load "paren")
(if (>= emacs-major-version 20)
    (auto-compression-mode 1)
  (load-library "uncompress")
  )
(put  'downcase-region   'disabled nil)
(put  'eval-expression   'disabled nil)
(put  'upcase-region     'disabled nil)
;(load-file "/usr/share/emacs/site-lisp/auctex/tex-site.elc")
;(require 'tex-site)
;(resize-minibuffer-mode)
(setq archie-search-type "case-insensitive")
(setq archie-server "archie.luth.se")
(setq fill-individual-varying-indent t)
(setq font-lock-maximum-decoration t)
(setq line-number-mode t)
(setq list-directory-verbose-switches "-alF")
(if (< emacs-major-version 20)
    (setq ps-paper-type 'ps-a4)
  (setq ps-paper-type 'a4))
(setq sentence-end-double-space nil)
(if (string= system-type "gnu/linux")
    (setq shell-file-name "/bin/bash")
    (setq shell-file-name "/bin/sh"))
(setq text-mode-hook  '(lambda () (auto-fill-mode 1)))
(setq trim-versions-without-asking t)
(setq truncate-lines t)
;(auto-show-mode t)
;(setq visible-bell t)
(setq visible-bell nil)
(setq-default next-line-add-newlines nil)
;(standard-display-european 1)
;(set-language-environment "Latin-1")
;(set-input-method "latin-1-prefix") ;; or "latin-1-postfix"
(setq scroll-step 2)
(setq sh-indent-for-then 0)
(setq sh-indent-for-do 0)
(setq sh-indent-after-do '+)
(setq-default require-final-newline nil)
(setq Man-overstrike-face font-lock-constant-face)
(setq Man-underline-face font-lock-comment-face)
(autoload 'faxed-mode "faxed" "Faxed mode is a minor mode for Dired." t)
(autoload 'faxed "faxed" "Run Dired on directory DIRECTORY with turned on Faxed mode." t)
(setq fax-view-program "fax")
(setq fax-view-switches (list "view"))
(setq fax-print-program "fax")
(setq fax-print-switches (list "print"))
(setq faxed-default-directory "/var/spool/fax")
(setq faxed-listing-switches "-Alt")
(setq faxed-page-extension-regexp "\\.[0-9]+")
(setq mouse-yank-at-point t)
(menu-bar-mode -1)
(set-scroll-bar-mode 'left)
(cond ((> emacs-major-version 20)
       (tool-bar-mode -1)
       (blink-cursor-mode -1)
       (setq dired-recursive-deletes 'top)
       (setq default-frame-alist
	     (append (list (cons 'scroll-bar-width 7))
		     default-frame-alist))
       (setq rmail-confirm-expunge nil)
       (set-language-environment 'UTF-8)
       (setq default-indicate-empty-lines t)
       )
      (t
       (setq default-frame-alist
	     (append (list (cons 'scroll-bar-width 10))
		     default-frame-alist))
       )
      )
;(default-value 'show-trailing-whitespace)
(setq bookmark-save-flag 1)
(setq bookmark-completion-ignore-case 1)
(setq shell-prompt-pattern "^[^#$%>\n]*[#$%>}] *")
(setq auto-mode-alist (cons '("\\.sw$" . sh-mode) auto-mode-alist))
 
(setq load-path (cons "~/emacs/lisp" load-path))
(setq load-path (cons "~/git/p6mode" load-path))
;(setq load-path (cons "~/emacs/lisp/custom-1.9962" load-path))
;(setq load-path (cons "~/emacs/lisp/g-client" load-path))

(define-key global-map "\C-x\C-c"
   (lambda ()
     "Don't save-buffers-kill-emacs."
     (interactive)
     (message "Use 'M-x please-save-buffers-kill-emacs' to exit.")))
(defun please-save-buffers-kill-emacs ()
     "Do save-buffers-kill-emacs."
     (interactive)
     (save-buffers-kill-emacs)
)

(require 'tramp)
;(add-to-list 'tramp-default-proxies-alist '("angus" nil "/ssh:mars.init.se:"))
;(add-to-list 'tramp-default-method-alist '("angus" nil "ssh"))
;(add-to-list 'tramp-default-proxies-alist '("scorpio" nil "/ssh:mars.init.se:"))
;(add-to-list 'tramp-default-method-alist '("scorpio" nil "ssh"))
;(add-to-list 'tramp-default-proxies-alist '("lekstugan" nil "/ssh:mars.init.se:"))
;(add-to-list 'tramp-default-method-alist '("lekstugan" nil "ssh"))

;(add-to-list 'tramp-default-proxies-alist '("931" nil "/ssh:922:"))
;(add-to-list 'tramp-default-proxies-alist '("358" nil "/ssh:922:"))
;(add-to-list 'tramp-default-method-alist '("931" nil "ssh"))
;(add-to-list 'tramp-default-method-alist '("358" nil "ssh"))

(add-to-list 'tramp-default-proxies-alist '("skot" "root" "/ssh:%h:"))
(add-to-list 'tramp-default-method-alist '("skot" "root" "sudo"))
(add-to-list 'tramp-default-proxies-alist '(nil "root" "/ssh:%h:"))
(add-to-list 'tramp-default-method-alist '(nil "root" "sudo"))
;(setq tramp-default-proxies-alist '(("angus" nil "/ssh:mars.init.se:") ("lekstugan" nil "/ssh:mars.init.se:") ("scorpio" nil "/ssh:mars.init.se:")))
;(setq tramp-default-method-alist '(("angus" nil "ssh") ("lekstugan" nil "ssh") ("scorpio" nil "ssh")))
;(setq tramp-default-proxies-alist nil)
;(setq tramp-default-method-alist nil)

;(cond ((or (and (>= emacs-major-version 21) (>= emacs-minor-version 4))
;           (> emacs-major-version 21))
;       (setq tramp-default-method "scp")
(setq tramp-default-method "scp")
;(setq tramp-unified-filenames t)
;(load-file "/usr/local/share/emacs/site-lisp/tramp.el")
;(if (string< emacs-version "21.4.2")
;    (lambda()
;     (if (string< tramp-version "2.1.14") (load-file "~/.emacs.tramp"))
;     (setq tramp-methods (append tramp-methods
;				 '(("kt"
;				    (tramp-connection-function tramp-open-connection-rsh)
;				    (tramp-login-program "telnet") ; 2.0.36
;				    (tramp-copy-program "rcp") ; 2.0.36
;				    (tramp-rsh-program "telnet")
;				    (tramp-rcp-program "rcp")
;				    (tramp-remote-sh "/bin/sh")
;				    (tramp-rsh-args ("-x"))
;				    (tramp-rcp-args nil)
;				    (tramp-login-args nil) ; 2.0.36
;				    (tramp-copy-args nil) ; 2.0.36
;				    (tramp-rcp-keep-date-arg "-p")
;				    (tramp-password-end-of-line nil) ; 2.0.36
;				    ))))
;     (setq tramp-methods (append tramp-methods
;				 '(("ktu"
;				    (tramp-connection-function tramp-open-connection-rsh)
;				    (tramp-login-program "ktelnet") ; 2.0.36
;				    (tramp-copy-program nil) ; 2.0.36
;				    (tramp-rsh-program "ktelnet")
;				    (tramp-rcp-program nil)
;				    (tramp-remote-sh "/bin/sh")
;				    (tramp-rsh-args ("-x"))
;				    (tramp-rcp-args nil)
;				    (tramp-login-args nil) ; 2.0.36
;				    (tramp-copy-args nil) ; 2.0.36
;				    (tramp-rcp-keep-date-arg "-p")
;				    (tramp-su-program nil)
;				    (tramp-su-args nil)
;				    (tramp-password-end-of-line nil) ; 2.0.36
;				    (tramp-encoding-command nil)
;				    (tramp-decoding-command nil)
;				    (tramp-encoding-function nil)
;				    (tramp-decoding-function nil)
;				    (tramp-telnet-program nil)
;				    (tramp-telnet-args nil)))))
;     (add-to-list 'tramp-remote-path "/misc/pkg/subversion/bin")
;     (add-to-list 'tramp-remote-path "/usr/local/pkg/subversion/bin")
;     (add-to-list 'tramp-remote-path "/usr/xpg4/bin")
;     ;;(defun tramp-handle-set-file-modes (filename mode) t) ;; WTF?????
;     (if (string< tramp-version "2.1.14") (require 'ange-ftp))
;     ))
;(if (string< "2.1.0" tramp-version)
;    (
;     ;; (setq tramp-default-proxies-alist nil)
;     (add-to-list 'tramp-default-proxies-alist
;                  '("lekstugan" nil "/sshx:jonas@balrog:"))
;     ))

; "Stefan Monnier"  
; 16 Mar 2001 09:50:19 -0500
(define-key global-map "\C-c\C-r"
   (lambda ()
     "Use `tramp-compile' if in a tramp buffer, `compile' otherwise."
     (interactive)
     (call-interactively
      (if (tramp-tramp-file-p buffer-file-name)
          'tramp-compile 'compile))))

(autoload 'svn-status "psvn" "Subversion mode." t)
;(require 'perldoc)
;(bar-cursor-mode)
;(cond ((eq window-system 'x)
;       (highlight-current-line-on t)
;       (highlight-current-line-set-bg-color "#400")
;       (highlight-current-line-set-fg-color "none")))
(global-set-key [s-tab] 'cyclebuffer-forward)
(global-set-key [S-s-iso-lefttab] 'cyclebuffer-backward)
(global-set-key [s-backspace] 'cyclebuffer-backward)

(autoload 'php-mode  "php-mode" "Major mode to edit PHP files."  t)
;(setq auto-mode-alist (cons '("\\.php3?$" . php-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.ptp$"   . php-html-helper-mode) auto-mode-alist))
(autoload 'php-html-helper-mode  "html-helper-mode" "Major mode to edit php files."  t)
(setq php-mode-force-pear t)
(setq php-mode-user-hook
      '(lambda()
	 (abbrev-mode nil)
	 (setq tab-width 8)
	 (toggle-truncate-lines t)
	 ))


;(autoload 'apache-mode  "apache-mode" "Major mode to edit httpd.conf."  t)
(add-to-list 'auto-mode-alist '("\\.htaccess$"   . conf-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf$"  . conf-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf$"    . conf-mode))
(add-to-list 'auto-mode-alist '("access\\.conf$" . conf-mode))
(add-to-list 'auto-mode-alist '("apache\\.conf$" . conf-mode))
(add-to-list 'auto-mode-alist '("apache2\\.conf$" . conf-mode))

(autoload 'mc  "mc" "Midnight Commander mode."  t)

;; Needed if iswedish is default dictionary...
;(setq ispell-dictionary "svenska8")
;(setq ispell-dictionary-alist
;      '(("svenska"
;	 "[A-Za-z\345\344\366\305\304\366]"  "[^A-Za-z\345\344\366\305\304\366]"
;	 "[']" nil ("-d" "svenska") "~list"
;	 iso-latin-1)
;	("svenska8"
;	 "[A-Za-z\345\344\366\305\304\366]"  "[^A-Za-z\345\344\366\305\304\366]"
;	 "[']" nil ("-B" "-d" "svenska") "~list"
;	 iso-latin-1)
;	)) 
;;; översikt

;(setq gnus-select-method
;;(setq gnus-secondary-select-methods
;      '(nnimap "okq8mex5"
;		(nnimap-address "okq8mex5")
;		(nnimap-server-port 143)
;		(nnimap-expunge-on-close 'always)
;		(nnimap-list-pattern ("%"))
;		))
(setq nnimap-debug "*nnimap-debug*")
(setq gnus-secondary-select-methods
      '(
	(nnimap "init"
		(nnimap-address "localhost")
		(nnimap-server-port 1430)
		(nnimap-list-pattern ("*"))
		)))

;(add-to-list 'vc-handled-backends 'SVN)
(setq-default ediff-ignore-similar-regions t)
(global-set-key "\C-xve" 'vc-ediff)
(defun vc-svn-ediff ()
  "Ediff revisions REV1 REV2 of the current buffer.
If the current buffer is named `F', the revisions are named `F.~REV?~'.
If `F.~REV?~' already exists and `REV?' is not a symbolic revision, the
existing file is used instead of being refetched."
  (interactive)
  (require 'vc)
  (vc-ensure-vc-buffer)
  (and
   (buffer-modified-p)
   (y-or-n-p (format "Save changes in buffer %s: " (buffer-name)))
   (save-buffer))
  (let* ((working-file (buffer-name))
         (rev1 (read-string "Revision to diff (working copy): "))
         (work (cadr (vc-svn-run-status (buffer-file-name))))
         ;(chgd (cddr (vc-svn-run-status (buffer-file-name) t)))
         (rev2 (read-string (concat "Revision to diff against (" work "): ")))
         (file1 (if (string-equal rev1 "")
                    (buffer-file-name)
                  (concat buffer-file-name ".~" rev1 "~")))
	 (version2 (if (string-equal rev2 "") work rev2))
	 (file2 (concat buffer-file-name ".~" version2 "~"))
         (fetch-file
          (lambda (file rev)
            (if (or (not (file-exists-p file))(string-match "[^0-9.]" rev))
                (progn
                  (find-file file)
                  (if buffer-read-only (toggle-read-only))
                  (erase-buffer)
                  (message "Fetching %s..." (buffer-name))
                  (vc-svn-find-version working-file rev t)
                  (save-buffer 0)(toggle-read-only t))))))
    (funcall fetch-file file1 rev1)
    (funcall fetch-file file2 version2)
    (ediff-files file1 file2)))
(defun vc-rcs-ediff ()
  "Ediff revisions REV1 REV2 of the current buffer.
If the current buffer is named `F', the revisions are named `F.~REV?~'.
If `F.~REV?~' already exists and `REV?' is not a symbolic revision, the
existing file is used instead of being refetched."
  (interactive)
  (require 'vc)
  (vc-ensure-vc-buffer)
  (and
   (buffer-modified-p)
   (y-or-n-p (format "Save changes in buffer %s: " (buffer-name)))
   (save-buffer))
  (let* ((working-file (buffer-name))
         (rev1 (read-string "Revision to diff (working copy): "))
         (work (vc-rcs-working-revision (buffer-file-name)))
         (rev2 (read-string (concat "Revision to diff against (" work "): ")))
         (file1 (if (string-equal rev1 "")
                    (buffer-file-name)
                  (concat buffer-file-name ".~" rev1 "~")))
	 (version2 (if (string-equal rev2 "") work rev2))
	 (file2 (concat buffer-file-name ".~" version2 "~"))
         (fetch-file
          (lambda (file rev)
            (if (or (not (file-exists-p file))(string-match "[^0-9.]" rev))
                (progn
                  (find-file file)
                  (if buffer-read-only (toggle-read-only))
                  (erase-buffer)
                  (message "Fetching %s..." (buffer-name))
                  (vc-rcs-find-revision working-file rev t)
                  ;(save-buffer 0)
                  (normal-mode)
                  (set-buffer-major-mode (current-buffer))
                  (not-modified)(toggle-read-only t)))
            (buffer-name))))
    ;(funcall fetch-file file1 rev1)
    ;(funcall fetch-file file2 version2)
    ;(ediff-files file1 file2)))
    (ediff-buffers (funcall fetch-file file1 rev1) (funcall fetch-file file2 version2))))

(defun vc-svn-changed-version (file)
  "Return the current workfile version of FILE."
  (interactive "f")
  (cddr (vc-svn-run-status file t)))

(autoload 'tmenu-menubar "tmenu"
  "Text based interface to the menubar."
  t nil)
(global-set-key [f10] 'tmenu-menubar)
;(require 'completing-help)
(autoload 'iman "iman" "Call the viewers of man pages and GNU Info with completion." t nil)
(global-set-key "\C-cm" 'iman)    ; `control c', then `m' calls `iman'
(setq iman-Man-index-command-and-args '("man" "-k" "."))

(autoload 'vm "vm" "Start VM on your primary inbox." t)
(autoload 'vm-mail "vm" "Send a mail message using VM." t)
(autoload 'post-mode "post" "Mutt post mode." t)

(setq
 vm-mime-qp-decoder-program "qp-decode"
 vm-mime-qp-encoder-program "qp-encode"
 vm-mime-base64-decoder-program "base64-decode"
 vm-mime-base64-encoder-program "base64-encode"
 vm-mime-8bit-text-transfer-encoding "8bit"
 )

(setq vm-mime-charset-font-alist
      '(
        ("iso-8859-1"   . "-misc-fixed-medium-r-normal--13-120-75-75-c-70-iso8859-1")
        ("iso-8859-15"  . "-misc-fixed-medium-r-normal--13-120-75-75-c-70-iso8859-15")
        ("Windows-1252" . "-misc-fixed-medium-r-normal--13-120-75-75-c-70-iso8859-1")
        ("Windows-1251" . "-misc-fixed-medium-r-normal--13-120-75-75-c-70-koi8-r")
        ("iso-8859-5" . "-misc-fixed-medium-r-normal--13-120-75-75-c-70-koi8-r")
        ))

(setq vm-pop-md5-program "md5sum"
      vm-toolbar-pixmap-directory "/usr/share/emacs/site-lisp/vm/etc"
      vm-image-directory "/usr/share/emacs/site-lisp/vm/etc"
      )
(defun spam ()
  "Register as spam with spamprobe and save to spam folder."
  (interactive)
  (vm-pipe-message-to-command "spamprobe spam" nil)
  (vm-save-message "~/Mail/spam")
;  (vm-delete-message nil)
  (message "spam filed")
)

;(require 'u-vm-color)
;(add-hook 'vm-summary-mode-hook 'u-vm-color-summary-mode)
;(add-hook 'vm-select-message-hook 'u-vm-color-fontify-buffer)
(setq vm-mutable-frames nil)
(autoload 'vm-mail "vm" "VM mail, duh." t)
(autoload 'vm-reply "vm-mail" "VM mail, duh." t)
;(global-set-key "\C-xm" 'vm-mail)
(global-set-key
 "\C-xm" (lambda()
           (interactive)
           (require 'vm)
           (require 'vm-reply)
           (vm-mail)))
(global-set-key "\C-x9" 'vm-visit-folder)
(defun rmail nil)

(setq vm-make-spool-file-name
      '(lambda (folder) "Returns a spool file name for a folder" (interactive)
	 (if (string-match ".gz$" folder)
	     (setq folder (replace-match "" t t folder)))
	 (if (string-match "/" folder)
	     (replace-regexp-in-string "\\(.*\\)/" "\\1/procmail/" folder)
	   (concat "procmail/" folder))))
(setq vm-make-crash-box-name
      '(lambda (folder) "Returns a crash box name for a folder" (interactive)
	 (concat folder ".CRASH")))
;(funcall vm-make-spool-file-name  "foo/bar.gz")
(setq vm-primary-inbox "~/Mail/INBOX.gz")
(setq-default vm-summary-show-threads nil)

(setq vm-mime-external-content-types-alist
      '(
	("text/html" 	"firefox")
	("image/png" 	"qiv")
	("image/gif" 	"qiv")
	("image/jpeg" 	"qiv")
	("video/mpeg" 	"mpeg_play")
	("video" 	"xanim")
	("application/postscript" 	"gv")
	("application/pdf" 	"acroread")
	("application/x-msexcel" 	"gnumeric")
	("application/msexcel" 	"gnumeric")
	("application/vnd.ms-excel" 	"gnumeric")
	("application/msword" 	"abiword")
	("application/rtf" 	"abiword")
	("application/ms-tnef" 	"tnef -C tnef")
	)
      )

(defun vm-exquit ()
  "Expunges buffer and quits." (interactive)
  (vm-expunge-folder)(vm-quit))
;(setq vm-mode-hook nil)
;(add-hook 'vm-mode-hook
(setq vm-mode-hook
	  '(lambda()
	     ;(setq vm-spool-files '("imap:okq8mex5:143:inbox:login:joli:*" "/home/jonas/mbox" "/var/mail/jonas"))
             ;(setq vm-spool-files '("/import/home/jonas/mbox" "/var/mail/jonas" "/home/jonas/mbox"))
             (setq vm-reply-ignored-addresses '("jonas@init.se"))
	     (setq vm-display-xfaces t)
	     (setq vm-mutable-frames nil)
	     (setq vm-startup-with-summary 2)
	     (setq vm-auto-displayed-mime-content-types '("text/plain" "text/enriched" "multipart"))
	     ;(setq vm-auto-displayed-mime-content-types nil)
	     (setq vm-auto-displayed-mime-content-type-exceptions '("text/html" "application"))
	     ;(setq vm-auto-displayed-mime-content-type-exceptions nil)
	     (setq vm-honor-mime-content-disposition nil)
	     ;(setq vm-mime-default-face-charsets '("us-ascii" "iso-8859-1"))
             (setq vm-mime-alternative-select-method '('favorite' "text/html"))
             (setq vm-mime-use-w3-for-text/html t)
             (setq vm-mime-default-face-charsets nil)
             ;;(add-to-list 'vm-mime-default-face-charsets "Windows-1251")
             (add-to-list 'vm-mime-default-face-charsets "iso-8859-1")
             (add-to-list 'vm-mime-default-face-charsets "us-ascii")
             (add-to-list 'vm-mime-default-face-charsets "iso-8859-15")
             (add-to-list 'vm-mime-default-face-charsets "Windows-1252")
	     (setq vm-delete-after-saving t)
	     (setq vm-delete-after-archiving t)
             (setq vm-infer-mime-types t)
	     (setq vm-move-after-deleting t)
	     (setq vm-move-after-undeleting t)
	     (setq vm-reply-subject-prefix "Re: ")
	     (setq vm-netscape-program "firefox")
             ;(setq vm-netscape-program "phoenix")
             ;(setq vm-summary-format "%n %*%a %-17.17F %-3.3m %2d %4l/%-5c %I\"%s\"\n")
             (setq vm-summary-thread-indent-level 3)
             (setq vm-summary-uninteresting-senders "jonas@init.se\\|jonas.linde@swip.net")
	     (setq vm-url-browser 'vm-mouse-send-url-to-netscape-new-tab)
	     (define-key vm-mode-map "q" 'vm-exquit)
	     (define-key vm-mode-map "i" 'other-window)
	     (define-key vm-mode-map "\C-m" 'vm-scroll-forward)
	     (define-key vm-mode-map [tab] 'other-window)
	     (define-key vm-mode-map [C-tab] 'vm-goto-message-last-seen)
             (define-key vm-mode-map "\C-x|" 'spam)
             (setq vm-auto-folder-alist
                   '(("^To:"
                      ("\\(owner-\\)?vml-q\\(-approval\\)?@init.se" . "vml-q")
                      ("^<?owner-vml-fn@init.se>?$" . "vml-fn-adm")
                      ("^<?vml-fn-approval@init.se>?$" . "vml-fn-adm")
                      ("^[^,]*<?vml-fn@init.se>?$" . "vml-fn")
                      ("vml-snr-approval@init.se" . "vml-snr-adm")
                      ("rak-approval@init.se" . "RAk")
                      ("^<?owner-vml-snr@init.se>?$" . "vml-snr-reject"))))
             (load-file "/usr/share/emacs/site-lisp/bbdb/lisp/bbdb-vm.el")
             (bbdb-initialize 'vm 'sc)
	     (define-key bbdb-mode-map [tab] 'other-window)
             (mc-install-read-mode)
	     ))

;;; exit bbdb when quitting vm by associating the bbdb quit
;;; command with the vm-quit-hook
(defun my-vm-quit-hook()
  "Save and quit BBDB when quitting RMAIL."
  (bbdb-save-db)
  (pop-to-buffer "*BBDB*")
  (bbdb-bury-buffer)
)
(add-hook 'vm-quit-hook 'my-vm-quit-hook)

(defun vm-mouse-send-url-to-netscape-new-tab (url &optional new-netscape new-window)
  ;; Change commas to %2C to avoid confusing Netscape -remote.
  (while (string-match "," url)
    (setq url (replace-match "%2C" nil t url)))
  (message "Sending URL to Netscape...")
  (if new-netscape
      (apply 'vm-run-background-command vm-netscape-program
	     (append vm-netscape-program-switches (list url)))
    (or (equal 0 (apply 'vm-run-command vm-netscape-program
			(append vm-netscape-program-switches
				(list "-remote"
				      (concat "openURL(\"" url
                                              "\",new-tab"
					      ")")))))
	(vm-mouse-send-url-to-netscape url t new-window)))
  (message "Sending URL to Netscape... done"))

;;;; JDE settings
;;(add-to-list 'load-path (expand-file-name "~/emacs/lisp/jde/lisp"))
;;(add-to-list 'load-path (expand-file-name "~/emacs/lisp/semantic"))
;;(add-to-list 'load-path (expand-file-name "~/emacs/lisp/speedbar"))
;;(add-to-list 'load-path (expand-file-name "/usr/share/emacs/site-lisp/elib"))
;;(require 'jde)

;(add-hook 'font-lock-mode-hook 'turn-on-lazy-lock)
(setq lazy-lock-minimum-size 1)
(setq lazy-lock-defer-on-scrolling t)
(setq lazy-lock-defer-time .25)
(setq lazy-lock-stealth-time 5)
(setq lazy-lock-stealth-lines 20)

(global-set-key [S-up] 'scroll-one-down-up)
(global-set-key "\e[a" 'scroll-one-down-up)
(defun scroll-one-down-up ()
  "Scrolls text 1 line down and moves point 1 line up." (interactive)
  (scroll-down 1)(next-line -1))
(global-set-key [S-down] 'scroll-one-up-down)
(global-set-key "\e[b" 'scroll-one-up-down)
(defun scroll-one-up-down ()
  "Scrolls text 1 line up and moves point 1 line down." (interactive)
  (scroll-up 1)(next-line 1))

(global-set-key [mouse-4]   (lambda (click) (interactive "e") (select-window (posn-window (event-start click))) (scroll-one-down-up)))
(global-set-key [mouse-5]   (lambda (click) (interactive "e") (select-window (posn-window (event-start click))) (scroll-one-up-down)))
(global-set-key [C-mouse-4] (lambda (click) (interactive "e") (select-window (posn-window (event-start click))) (next-line -1)))
(global-set-key [C-mouse-5] (lambda (click) (interactive "e") (select-window (posn-window (event-start click))) (next-line 1)))
(global-set-key [S-mouse-4] (lambda (click) (interactive "e") (select-window (posn-window (event-start click))) (scroll-down)))
(global-set-key [S-mouse-5] (lambda (click) (interactive "e") (select-window (posn-window (event-start click))) (scroll-up)))

(defun yesbox ()
  (interactive "")
  (cvs-status "~/yb/yesbox" nil))
(defun yesbox-printer ()
  (interactive "")
  (setq ps-printer-name "yesbox"))

(autoload 'zenirc "zenirc" "Waste of time" t)
(setq zenirc-nick-default "krakan")
;(setq zenirc-server-default "saltlake.ut.us.undernet.org")
;(setq zenirc-server-default "rockhill.sc.us.undernet.org")
;(setq zenirc-server-default "bc.ca.undernet.org")
;(setq zenirc-server-default "irc.ludd.luth.se")
(setq zenirc-server-default "us.undernet.org")

(setq woman-use-own-frame nil)
(setq woman-always-colour-faces t)
;(setq woman-manpath (list "/usr/share/man" "/usr/local/man" "/usr/man" "/usr/X11R6/man"))
(add-hook 'woman-pre-format-hook
;; This shouldn't be needed...
	  (function
	   (lambda ()
	     (copy-face 'italic 'woman-italic-face)
	     (set-face-foreground 'woman-italic-face "OrangeRed")
	     (copy-face 'bold 'woman-bold-face)
	     (set-face-foreground 'woman-bold-face "Aquamarine")
	     )))
(if (eq emacs-major-version 20)
    (defgroup woman nil
      "Browse UNIX manual pages `wo (without) man'."
      :tag "WoMan" :group 'help :load "woman"))
(setq woman-imenu t)
(setq woman-cache-filename "~/.wmncach.el")
(cond ((< emacs-major-version 21)
       (autoload 'woman "woman"
	 "Decode and browse a UN*X man page." t)
       (autoload 'woman-find-file "woman"
	 "Find, decode and browse a specific UN*X man-page file." t)
       (autoload 'woman-dired-find-file "woman"
	 "In dired, run the WoMan man-page browser on this file." t)
       ))
(add-hook 'dired-mode-hook
	  (function
	   (lambda ()
	     (define-key dired-mode-map "w" 'woman-dired-find-file))))
(global-set-key "\C-cw"
		(function (lambda ()
			    (interactive)
			    (let ((woman-topic-at-point t))
			      (woman)))))
(global-set-key "\C-xw"
		'woman-find-file)

(add-hook 'dired-load-hook
	  (function (lambda () (load "ls-lisp"))))

;(setq ps-lpr-command "lpr")
;(setq ps-printer-name "p17")
;(setq ps-lpr-switches (list "-P" ps-printer-name))
(global-set-key [C-S-f12]   'ps-print-buffer)
(global-set-key [C-M-S-f12] 'ps-print-buffer-with-faces)
(global-set-key [C-S-f11]   'ps-spool-buffer)
(global-set-key [C-M-S-f11] 'ps-spool-buffer-with-faces)
(global-set-key [C-S-f10]   'ps-print-region)
(global-set-key [C-M-S-f10] 'ps-print-region-with-faces)
(global-set-key [C-S-f9]    'ps-spool-region)
(global-set-key [C-M-S-f9]  'ps-spool-region-with-faces)
(global-set-key [C-M-f11]   'ps-despool)
(global-set-key [M-f11]     'ps-unspool)
(global-set-key [C-f11]     'ps-count-spool)
(global-set-key [C-f9]      'ps-view-spool)
(global-set-key [C-f12]     'lpq)
(global-set-key [M-f12]     'lprm)
(defun ps-landscape-mode  (arg)
  "Toggle landscape mode printing."
  (interactive "P")
  (setq ps-landscape-mode (if arg (if (eq arg 0) nil t) (not ps-landscape-mode)))
  (message  "Postscript landscape mode = %s" ps-landscape-mode))
(defun ps-unspool  ()
  "Kill the postscript spool buffer."
  (interactive)
  (kill-buffer "*PostScript*")
  (message "Postscript buffer deleted."))
(defun ps-view-spool ()
  "View the postscript spool buffer."
  (interactive)
  (set-buffer "*PostScript*")
  (switch-to-buffer "*PostScript*"))
;(defun lpq (&optional prefix-arg)
;  "View print queue."
;  (interactive "P")
;  (let ((printer (if prefix-arg
;      (completing-read "Printer: " '(("68psc") ("63psc")))
;      printer)))
;  (shell-command (concat "lpq -P" printer))))
;(defun lprm (job &optional prefix-arg)
;  "Delete a job from the print queue."
;  (interactive "nJob: \nP")
;  (let ((printer (if prefix-arg
;      (completing-read "Printer: " '(("68psc") ("63psc")))
;      printer)))
;  (shell-command (concat "lprm -P" printer " " job))
;  (shell-command (concat "lpq -P" printer))))
(defun lpq ()
  "View print queue."
  (interactive)
  (shell-command (concat "lpq" (if ps-printer-name (concat " -P" ps-printer-name)))))
(defun lprm (job)
  "Delete a job from the print queue."
  (interactive "NJob: ")
  (shell-command (concat "lprm " job))
  (lpq))
(defun ps-count-spool ()
  "How many pages were just spooled?"
  (interactive)
  (set-buffer "*PostScript*")
  (save-excursion
  (goto-char (point-max))
  (re-search-backward "^%%Page:")
  (end-of-line) (setq eol (point)) (forward-word -1)
  (message "Pages: %s" (buffer-substring (point) eol))
  ))
(defun printer (printer)
  "Set the printer name."
  (interactive "MPrinter: ")
  (setq ps-printer-name printer) 
  )

(global-set-key "\C-x\M-q" 'toggle-read-only)

(setq ange-ftp-generate-anonymous-password "jonas@init.se")
;(ange-ftp-add-dumb-unix-host "w1.533.telia.com")
(setq ange-ftp-dumb-unix-host-regexp "^w1\\.533\\.telia\\.com$")
;(setq ange-ftp-ftp-program-name "ftp")
(setq ange-ftp-ftp-program-name "ftp")
;(setq ange-ftp-ftp-program-name "hsftp"); doesn't work either
(defun mysftp (arg)
  "Toggle mysftp/ftp for ange-ftp. If optional arg is C-u load tramp instead."
  (interactive "P")
  (if (and (listp arg) (eq (car arg) 4))
      (and (load "tramp")
           (setq ange-ftp-ftp-program-name "tramp"))
    (load "ange-ftp")
    (setq ange-ftp-ftp-program-name
          (if (null arg)
              (if (string= ange-ftp-ftp-program-name "mysftp") "ftp" "mysftp")
            (if (> arg 0) "mysftp" "ftp"))))
(message ange-ftp-ftp-program-name))
;(setq ange-ftp-ftp-program-args nil)

;(load "swedish")
;(load "iso-insert")
;(load "iso-mime" 1)
;(or (= emacs-major-version 20)(load "hakpar")) ; doesn't work with emacs 20.3...

;;; dummy settings
;(global-set-key "\C-c\C-c" 'exchange-point-and-mark)
;(global-set-key "\C-c\C-e" 'eval-last-sexp)
;(global-set-key "\C-c\C-f" 'find-file)
;(global-set-key "\C-c\C-s" 'save-buffer)
;(global-set-key "\C-c\C-v" 'find-alternative-file)
;(global-set-key "\C-c\C-z" 'kill-emacs)
;(global-set-key "\C-ck" 'kill-buffer)
;(global-set-key "\C-co" 'other-window)
;(global-set-key "\C-c0" 'delete-window)
;(global-set-key "\C-c1" 'delete-other-windows)
;(global-set-key "\C-c2" 'split-window-vertically)
;(global-set-key "\C-c3" 'split-window-horizontally)

;;; Supercite settings
(add-hook 'mail-citation-hook 'sc-cite-original)
;(defun jl-fix-from-line ()
;  "Purge from address in citation line."
;  (let (
;	 (to (point))
;	 (from (re-search-backward "^And "))
;	 )
;;    (quoted-printable-to-latin1 from to)
;    (and (re-search-forward "And .*[< )]\\([A-Za-z0-9_.@]+\\)>? spoke" nil t)
;	  (replace-match "And \\1 spoke"))
;    ))
;; And =?iso-8859-1?Q?=22Thor=E9n=2C_Linda=22?= <Linda.Thoren@okq8.se> spoke
;(add-hook 'sc-post-hook 'jl-fix-from-line)
(add-hook 'sc-load-hook
	  '(lambda()
	     (defun sc-header-and-said ()
	       "\"And <from> spoke unto the world. And said:\" 
unless the \"from\" field cannot be found, in which case nothing is inserted"
	       (let ((sc-mumble "")
		     (whofrom (sc-whofrom)))
		 (if whofrom
		     (insert sc-reference-tag-string
			     "And " 
			     (or (sc-mail-field "sc-from-address")
				 (sc-mail-field "sc-reply-address") )
			     " spoke unto the world. And said:\n"))))
	     (setq sc-rewrite-header-list '((sc-no-header) (sc-header-and-said)))
	     ;(setq news-reply-header-hook nil)
	     (setq sc-nested-citation-p t)
	     ;(setq sc-blank-lines-after-headers 1)
	     (setq sc-citation-leader nil)
	     (setq sc-reference-tag-string "")
	     (setq sc-confirm-always-p nil)
	     (setq sc-preferred-header-style 1)
	     (setq sc-auto-fill-region-p nil)
	     ))

;;;;; Commands added by calc-private-autoloads on Tue Apr 27 23:59:38 1999.
;;(autoload 'calc-dispatch	   "calc" "Calculator Options" t)
;;(autoload 'full-calc		   "calc" "Full-screen Calculator" t)
;;(autoload 'full-calc-keypad	   "calc" "Full-screen X Calculator" t)
;;(autoload 'calc-eval		   "calc" "Use Calculator from Lisp")
;;(autoload 'defmath		   "calc" nil t t)
;;(autoload 'calc			   "calc" "Calculator Mode" t)
;;(autoload 'quick-calc		   "calc" "Quick Calculator" t)
;;(autoload 'calc-keypad		   "calc" "X windows Calculator" t)
;;(autoload 'calc-embedded	   "calc" "Use Calc inside any buffer" t)
;;(autoload 'calc-embedded-activate  "calc" "Activate =>'s in buffer" t)
;;(autoload 'calc-grab-region	   "calc" "Grab region of Calc data" t)
;;(autoload 'calc-grab-rectangle	   "calc" "Grab rectangle of data" t)
;;(setq load-path (nconc load-path (list "~/emacs/lisp/calc-2.02f")))
(autoload 'calc-record-compilation-date-macro "calc-macs" "Vfn?" t)
(global-set-key "\e#" 'calc-dispatch)
;;;;; End of Calc autoloads.

(autoload 'sgml-mode "psgml" "Major mode to edit SGML files." t)
(autoload 'xml-mode  "psgml" "Major mode to edit XML files."  t)
(setq auto-mode-alist (cons '("\\..*ml$" . sgml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.xml$" . xml-mode) auto-mode-alist))
(setq sgml-set-face 1)
(setq sgml-markup-faces
      '(
	(start-tag . font-lock-variable-name-face)
	(end-tag   . font-lock-variable-name-face)
	(comment   . font-lock-comment-face)
	(doctype   . font-lock-builtin-face)
	(ignored   . font-lock-string-face)
	(ms-start  . font-lock-string-face)
	(ms-end    . font-lock-string-face)
	(pi        . font-lock-function-name-face)
	(sgml      . font-lock-constant-face)
	(entity    . font-lock-keyword-face)
	(shortref  . font-lock-type-face)
	))

(setq nxml-mode-hook
      '(lambda()
         (abbrev-mode -1)
         (setq tab-width 4)
         (setq indent-tabs-mode t)
         (setq nxml-attribute-indent 4)
         (setq nxml-child-indent 4)
         (auto-fill-mode 0)
         (font-lock-mode t)))

;; html-helper-mode settings
(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(setq auto-mode-alist (cons '("\\.s?ht.l?\\(\\.gz\\)?$" . html-helper-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.jsp$" . html-helper-mode) auto-mode-alist))
(setq html-helper-htmldtd-version "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 3.2//EN\">\n")
(setq html-helper-htmldtd-version "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n")
(setq html-helper-htmldtd-version "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"DTD/xhtml1-loose.dtd\">\n")
(setq html-helper-address-string "<A HREF=\"/http://www.init.se/~jonas/\">jonas@init.se</A>")
(setq html-helper-use-expert-menu t)
(setq html-helper-mode-hook 
      '(lambda () 
         (auto-fill-mode nil)
	 (tempo-define-template "html-skeleton" html-helper-new-buffer-template t "Insert a skeleton for a HTML document")
	 ))
(setq html-helper-new-buffer-template
      '(html-helper-htmldtd-version
	"<html>\n"
	"<head>\n"
	"<title>" p "</title>\n"
	"<link rev=\"made\" href=\"mailto:jonas@init.se\">\n"
	"</head>\n\n<body bgcolor=\"white\">\n"
	"<h1>" p "</h1>\n\n"
	p "qwe"
	"\n\n<hr>\n"
	"<a href=\"http://validator.w3.org/check/referer\">"
	"<img src=\"pics/valid_html4.0.png\" alt=\"HTML 4.0 Checked!\" align=\"right\" border=\"0\" width=\"48\" height=\"32\"></a>"
;	 "<A HREF=\"http://www.hensa.ac.uk/html-val-svc/?URLs=http://www.init.se/~jonas/"
;;;	(substring (buffer-file-name) (string-match WWW (buffer-file-name))) "\">\n"
;;;	(substring (buffer-file-name) 27) "\">\n"
;	 (buffer-file-name) "\">\n"
;	 "<IMG SRC=\"/~jonas/valid-html3.2.gif\" ALT=\"HTML 3.2 Checked!\" "
;	 "ALIGN=right WIDTH=48 HEIGHT=32 BORDER=0></A>\n"
	"<P ALIGN=center><FONT SIZE=-1><I>\nUpdated\n"
	html-helper-timestamp-start
	html-helper-timestamp-end
	"\nby:" html-helper-address-string "\n</I></FONT></P>\n<HR>"
	"\n</BODY>\n</HTML>\n"))

(setq html-helper-timestamp-hook 'html-helper-JL-insert-timestamp)
(defun html-helper-JL-insert-timestamp ()
  "Default timestamp insertion function."
  (let ((time (current-time-string)))
    (insert (substring time 0 20)
	    (nth 1 (current-time-zone))
	    " "
	    (substring time -4)
	    "\n")))

;; VRML-mode
(autoload 'vrml-mode "vrml-mode" "VRML mode." t)
(setq auto-mode-alist (append '(("\\.wrl\\'" . vrml-mode)) auto-mode-alist))

;; Settings for rmail
(setq rmail-file-name "~/Mail/rmail/RMAIL")
;(setq rmail-default-rmail-file "~/Mail/Privat.gz")
(setq rmail-primary-inbox-list '("/home/jonas/Mail/rmail/mbox"))
;(setq rmail-primary-inbox-list "/usr/spool/mail/jonas")
;(setq rmail-primary-inbox-list "po:jonas")
;(setq rmail-pop-password "siddg")
;(setq rmail-pop-password-required t)
(defun femail ()
  "Fetch mail via the fetchmail program and then run RMAIL."
  (interactive)
  (shell-command "xterm -rv -g 52x3 +sb -e fetchmail")
;  (shell-command "fetchmail -silent")
  (rmail))
;(defun rmail-replaj  (all)
;  "Reply to the current message.
;Normally ignore CC: to all other recipients of original message;
;prefix argument means include them."
;  (interactive "P")
;  (rmail-reply (not all)))
(if (>= emacs-major-version 21)
    (setq rmail-ignored-headers
	  (concat
	   (replace-regexp-in-string
	    (concat "\\^mime-[^:]+:\\\\|"
		    "\\|\\^content-[^:]+:\\\\|"
		    ) "" rmail-ignored-headers)
	   "\\|^X-MS-[^:]+:")))

(defun Ptest (arg)
  (interactive "P")
  (if (listp arg) (message (number-to-string (car arg)))
    (if (numberp arg) (message (number-to-string arg))
      (if (symbolp arg) (message (symbol-name arg))
	(message arg)))))

(defun rmail-replaj (not-just-sender)
  "Reply to the current message.
Normally ignore CC: to all other recipients of original message;
prefix argument means include them.  While composing the reply,
use \\[mail-yank-original] to yank the original message into it.
The prefix argument handling is inverted from rmail-reply.
C-u as prefix means reply-to-list; - means really-reply-to-all."
  (interactive "P")
  (let (from reply-to cc subject date to message-id references
	     resent-to resent-cc resent-reply-to
	     (reply-to-list                       ; jonas@init.se [2000-12-12]
	      (and (listp not-just-sender)        ; jonas@init.se [2000-12-12]
		   (eq 4 (car not-just-sender))   ; jonas@init.se [2000-12-12]
		   (not (setq not-just-sender nil)))) ; jonas@init.se [2000-12-12]
	     (msgnum rmail-current-message))
    (save-excursion
      (save-restriction
	(widen)
	(goto-char (rmail-msgbeg rmail-current-message))
	(forward-line 1)
	(if (= (following-char) ?0)
	    (narrow-to-region
	     (progn (forward-line 2)
		    (point))
	     (progn (search-forward "\n\n" (rmail-msgend rmail-current-message)
				    'move)
		    (point)))
	  (narrow-to-region (point)
			    (progn (search-forward "\n*** EOOH ***\n")
				   (beginning-of-line) (point))))
	(setq from (mail-fetch-field "from")
	      reply-to (or (mail-fetch-field "reply-to" nil t)
			   from)
	      cc (and not-just-sender
		      (mail-fetch-field "cc" nil t))
	      subject (mail-fetch-field "subject")
	      date (mail-fetch-field "date")
	      to (or (mail-fetch-field "to" nil t) "")
	      message-id (mail-fetch-field "message-id")
	      references (mail-fetch-field "references" nil nil t)
	      resent-reply-to (mail-fetch-field "resent-reply-to" nil t)
	      resent-cc (and not-just-sender
			     (mail-fetch-field "resent-cc" nil t))
	      resent-to (or (mail-fetch-field "resent-to" nil t) "")
;;;	      resent-subject (mail-fetch-field "resent-subject")
;;;	      resent-date (mail-fetch-field "resent-date")
;;;	      resent-message-id (mail-fetch-field "resent-message-id")
	      )))
    ;; Merge the resent-to and resent-cc into the to and cc.
    (if (and resent-to (not (equal resent-to "")))
	(if (not (equal to ""))
	    (setq to (concat to ", " resent-to))
	  (setq to resent-to)))
    (if (and resent-cc (not (equal resent-cc "")))
	(if (not (equal cc ""))
	    (setq cc (concat cc ", " resent-cc))
	  (setq cc resent-cc)))
    ;; Add `Re: ' to subject if not there already.
    (and (stringp subject)
	 (setq subject
	       (concat rmail-reply-prefix
		       (if (let ((case-fold-search t))
			     (string-match rmail-reply-regexp subject))
			   (substring subject (match-end 0))
			 subject))))
    (rmail-start-mail
     nil
     ;; Using mail-strip-quoted-names is undesirable with newer mailers
     ;; since they can handle the names unstripped.
     ;; I don't know whether there are other mailers that still
     ;; need the names to be stripped.
     ;;(mail-strip-quoted-names
     (or (and (eq '- not-just-sender) from) ; jonas@init.se [1999]
	 (or (and reply-to-list to) ; jonas@init.se [2000-12-12]
	     reply-to));;) ; jonas@init.se [2000-12-12]
     subject
     (rmail-make-in-reply-to-field from date message-id)
     (if not-just-sender
       (let* ((cc-list (rmail-dont-reply-to
			 (if (null cc) to (concat to ", " cc)))))
	 (if (string= cc-list "") nil cc-list)))
     rmail-view-buffer
     (list (list 'rmail-mark-message
		 rmail-view-buffer
		 (aref rmail-msgref-vector msgnum)
		 "answered"))
     nil
     (list (cons "References" (concat (mapconcat 'identity references " ")
				      " " message-id)))))
)

(defun rmail-summary-replaj (not-just-sender)
  "Reply to the current message.
Normally ignore CC: to all other recipients of original message;
prefix argument means include them."
  (interactive "P")
  (let ((window (get-buffer-window rmail-buffer)))
    (if window
	(select-window window)
      (set-buffer rmail-buffer)))
  (rmail-replaj not-just-sender)
  (use-local-map (copy-keymap (current-local-map)))
  (define-key (current-local-map)
    "\C-c\C-c" 'rmail-summary-send-and-exit))
(defun rmail-kvitt ()
  "Quit out of RMAIL and notify server client."
  (interactive)
  (rmail-expunge-and-save)
  ;; Don't switch to the summary buffer even if it was recently visible.
  (if rmail-summary-buffer
      (progn
	(replace-buffer-in-windows rmail-summary-buffer)
	(bury-buffer rmail-summary-buffer)))
  (let (obuf (current-buffer))
    (replace-buffer-in-windows obuf)
    (if server-buffer-clients (server-edit)
      (bury-buffer obuf))))
(defun rmail-kill ()
  "Really quit out of RMAIL and notify server client."
  (interactive)
  (rmail-expunge-and-save)
  ;; Don't switch to the summary buffer even if it was recently visible.
  (if rmail-summary-buffer
      (progn
	(replace-buffer-in-windows rmail-summary-buffer)
	(kill-buffer rmail-summary-buffer)))
  (let (obuf (current-buffer))
    (replace-buffer-in-windows obuf)
    (if server-buffer-clients (server-edit)
      (kill-buffer obuf))))

(defun rmail-mime-decode (dcode)
  "Decode a MIME-block into a file.
     Default encoding is Base64,
     with prefix arg > 1 Quoted-Printable and
     with prefix arg < 1 raw."
  (interactive "p")
  (and (= dcode 1) (setq decoder "mmencode -u"))
  (and (> dcode 1) (setq decoder "mmencode -u -q"))
  (and (< dcode 1) (setq decoder "cat"))
  (search-forward-regexp "^content-type: " nil)
  (search-forward-regexp "name=" nil)
  (forward-char 1)
  (let ((top (point)))
    (search-forward "\"" nil t)
    (let ((bot (- (point) 1)))
      (setq filename (buffer-substring top bot))))
  (search-forward-regexp "^\n" nil)
  (let ((top (point)))
    (forward-paragraph)
    (let ((bot (point)))
      (shell-command-on-region top bot decoder)))
  (switch-to-buffer-other-window "*Shell Command Output*")
  (write-file filename t)
  )

(autoload 'attach "etach" "E-mail attach/detach package" t)
(autoload 'detach "etach" "E-mail attach/detach package" t)
(autoload 'etach-mime-forward "etach" "E-mail attach/detach package" t)
(setq etach-prompt-me-for-file-names t)
(setq etach-spam-host-exclude-list '("localhost" "init.se" "master.init.se" "proxy.init.se" "starseed.com" "inanna.starseed.com"))
(setq etach-clean-decoded-plain-text t)
(setq etach-fill-decoded-plain-text nil)

(setq rmail-delete-after-output t)
(setq rmail-show-message-hook 'nil)
;;(autoload 'rmail-show-mime		"rmailmime" "Show MIME messages."  t)
;;(autoload 'rmail-convert-mime-header	"rmailmime" "Convert MIME header." nil)
;;(setq rmail-message-filter 'rmail-convert-mime-header)
;;(setq rmail-message-filter
;;	     (function
;;	      (lambda()
;;		(headers-to-latin1)
;;		)))
(add-hook 'rmail-summary-mode-hook
	  '(lambda()
	     (define-key rmail-summary-mode-map "r" 'rmail-summary-replaj)
	     (define-key rmail-summary-mode-map "\er" 'rmail-search-backwards)
	     (define-key rmail-summary-mode-map "\C-i" 'other-window)
	     (define-key rmail-summary-mode-map "F" 'etach-mime-forward)
	     (make-variable-buffer-local 'lazy-lock-stealth-time)
	     (setq lazy-lock-stealth-time nil)
	     ))
(add-hook 'rmail-mode-hook
;(setq rmail-mode-hook
	  '(lambda()
	     (setq font-lock-defaults
	       '(rmail-font-lock-keywords t nil nil nil
     		  (font-lock-maximum-size . nil)
     		  (font-lock-fontify-buffer-function . rmail-fontify-buffer-function)
     		  (font-lock-unfontify-buffer-function . rmail-unfontify-buffer-function)
     		  (font-lock-inhibit-thing-lock . (fast-lock-mode))))
	     (make-variable-buffer-local 'lazy-lock-stealth-time)
	     (setq lazy-lock-stealth-time nil)
	     (local-set-key "!" 'rmail-show-mime)
	     (define-key rmail-mode-map "r" 'rmail-replaj)
	     (define-key rmail-mode-map "\er" 'rmail-search-backwards)
	     (define-key rmail-mode-map "\C-i" 'other-window)
	     (define-key rmail-mode-map "\C-ca" 'browse-url-at-point)
	     (define-key rmail-mode-map "\C-cb" 'rmail-mime-decode)
	     (define-key rmail-mode-map "F" 'etach-mime-forward)
	     (defun rmail-quit ()
	       "Quit out of RMAIL and notify server client."
	       (interactive)
	       (rmail-kill))
            ))

;; Settings for mail
(setq mail-alias-separator-string '",\n    ")
;(setq mail-archive-file-name '"~/Mail/SMAIL")
(setq mail-archive-file-name nil)
(setq mail-default-headers 
      (concat "From: Jonas J Linde <jonas@init.se>\n"
	      ;"MIME-Version: 1.0\n"
	      ;"Content-Type: text/plain; charset=iso-8859-1\n"
	      ;"Content-Transfer-Encoding: 8bit\n"
	      "BCC: jonas@init.se\n"
	      ))
(setq mail-default-reply-to nil)
;(setq mail-header-separator  '"----")
(setq mail-mode-hook
      '(lambda ()
	 (auto-fill-mode 1)
	 (set-fill-column 70)
      ))
(setq mail-send-hook 'nil)
;(setq sendmail-program '"/usr/local/bin/emil -G mime_user | /usr/lib/sendmail")
;(setq sendmail-program "/usr/sbin/sendmail")
;(setq sendmail-program "~/etc/sendemil")
;;(setq mail-setup-hook nil)
(add-hook 'mail-setup-hook 'mail-abbrevs-setup)
(add-hook 'mail-setup-hook
	  '(lambda()
	     ;;(if (> emacs-minor-version 28)
	     (define-key mail-mode-map "\C-n" 'mail-abbrev-next-line)
	     (define-key mail-mode-map "\eOB" 'mail-abbrev-next-line)
	     (define-key mail-mode-map [down] 'mail-abbrev-next-line)
;	     (and (goto-char (point-max))
;		  (search-backward-regexp "^-- $" nil t)
;;		  (not (replace-match "/J                                                          08-407 01 15" t))
;		  (not (replace-match "/J" t))
;		  (goto-char (point-min))
;		  (end-of-line))
	     ));)
(setq mail-signature t)
(setq mail-yank-prefix "> ")

(setq mime-primary-boundary "eddies_in_the_time-space_continuum")
(setq mime-use-selective-display nil)
(setq mime-use-waiting-messages nil)
(setq mime-encode-plaintext-on-send t)
(setq mime-default-charset "ISO-8859-1")

(add-hook 'mail-mode-hook
	  '(lambda()
	     (define-key mail-mode-map "\C-cp" 'vm-mime-preview-composition)
	     (define-key mail-mode-map "\C-ca" 'browse-url-at-point)
	     (define-key mail-mode-map "\C-cb" 'mime-add-boundaries)
	     (define-key mail-mode-map "\C-c8" 'mime-just-include-file)))
(defun mime-add-boundaries ()
  "Q&D-hack to add MIME multipart boundaries to an e-mail message."
  (interactive)
  (save-excursion (goto-char (point-min))
  (and (re-search-forward "^MIME-Version: .*\n" nil t)(replace-match ""))
  (and (re-search-forward "^Content-Type: .*\n" nil t)(replace-match ""))
  (and (re-search-forward "^Content-Transfer-Encoding: .*\n" nil t)
       (replace-match ""))
  (forward-paragraph)(forward-line)
  (load "mime-compose")
  (mime-mimify-message)
  ))

(defun mime-just-include-file (filename &optional prefix-arg)
  "Just include a file named by FILENAME. With prefix arg, prompt for
character set. Blatantly snarfed from mime-compose.el."
  (interactive "fFilename: \nP")
  (let ((charset
         (if prefix-arg
             (completing-read "Character set: " mime-valid-charsets
                              nil nil nil)
           mime-default-charset))
        (content-type
         (completing-read "Content type (RET for default): "
                          mime-valid-include-types
                          nil nil nil)))
    (if (string= content-type "")
        (setq content-type "text/plain"))
    (if (string= charset "")
        (setq charset "asdfasdfdfsdafs"))
    (mime-just-include-file-please filename content-type charset))
  (mime-display-waiting-messages))

(defun mime-just-include-file-please (filename content-type &optional charset)
  "Include a file named by FILENAME and with MIME content type
CONTENT-TYPE.  Optional third arg CHARSET names character set for
data.  Data will NOT be encoded.  Blatantly snarfed from mime-compose.el."
  (mime-mimify-message)
  (push-mark)
  (insert "--" (mime-primary-boundary) "\n")
  (insert "Content-Type: " content-type)
  (if charset
      (insert "; charset=" charset))
  (if (and mime-name-included-files (not (string= filename mime-audio-file)))
      (insert "; name=\"" (file-name-nondirectory filename) "\""))
  (insert "\n")
  (if (not (string= filename mime-audio-file))
      (insert "Content-Description: " filename "\n"))
;  (if binary
;      (insert "Content-Transfer-Encoding: base64\n")
;    (insert "Content-Transfer-Encoding: quoted-printable\n"))
    (insert "Content-Transfer-Encoding: 8bit\n")
  (mime-maybe-highlight-region
   (save-excursion (re-search-backward
                    (concat "--" (mime-primary-boundary))) (point))
   (- (point) 1))
  (insert "\n")
  (let ((start (point)) end (seldisp selective-display))
    (next-line 1)
    (save-excursion
      (next-line -1)
      (insert-file filename))
    (setq end (- (point) 1))
    (setq selective-display nil)
;    (if binary
;        (shell-command-on-region start end mime-encode-base64-command t)
;      (shell-command-on-region start end mime-encode-qp-command t))
    (setq selective-display seldisp)
    (setq end (point))
    (mime-maybe-hide-region start (- end 1))
    (insert "\n")
    (insert "--" (mime-primary-boundary) "\n")
    (insert "Content-Type: text/plain\n")
    (mime-maybe-highlight-region
     (save-excursion (re-search-backward
                      (concat "--" (mime-primary-boundary))) (point))
     (- (point) 1))
    (insert "\n\n")
    (next-line -1)))

;; Settings for mailcrypt
;(autoload 'mc-install-write-mode "mailcrypt" nil t)
;(autoload 'mc-install-read-mode "mailcrypt" nil t)
;(add-hook 'mail-mode-hook 'mc-install-write-mode)
;(add-hook 'rmail-show-message-hook 'mc-install-read-mode)
;(add-hook 'rmail-mode-hook 'mc-install-read-mode)
;(add-hook 'rmail-summary-mode-hook 'mc-install-read-mode)
; needed for mailcrypt 3.5b:
;(and (load "mc-setversion" 1) (mc-setversion "pgp"))
(setq mc-pgp-path "gpg")
(setq mc-always-replace 'never)
(setq mc-pgp-always-sign 'never)
(setq mc-gpg-always-fetch nil)
(setq mc-pgp-always-fetch nil)
;; Key server at UIT (Tromso, Norway)
(setq mc-pgp-keyserver-address "wwwkeys.pgp.net")
(setq mc-pgp-keyserver-port 11371)
(setq mc-pgp-keyserver-url-template "/pks/lookup?op=get&search=%s")
; http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=jonas@init.se

;; Add to the standard modes
(setq auto-mode-alist (cons '("\\.env$" . sh-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.ubb$" . conf-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\..ptubb$" . conf-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\..ptdm$" . conf-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.dm$" . conf-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("wlstab$"   . conf-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("oastab$"   . conf-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("wwwtab$"   . conf-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("tuxtab$"   . conf-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("ictab$"   .  conf-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.xpi$"   . archive-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("/db\\.[^/]*$" . zone-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.eml$"   . mail-mode)    auto-mode-alist))
(setq auto-mode-alist (cons '("\\.pco$"   . cobol-mode)   auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cco$"   . cobol-mode)   auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cpc$"   . cobol-mode)   auto-mode-alist))
(setq auto-mode-alist (cons '("\\.inl$"   . cobol-mode)   auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cob$"   . cobol-mode)   auto-mode-alist))
(setq auto-mode-alist (cons '("\\.pkb$"   . sql-mode)   auto-mode-alist))
(setq auto-mode-alist (cons '("\\.pks$"   . sql-mode)   auto-mode-alist))
(setq auto-mode-alist (cons '("\\.sql$"   . sql-mode)   auto-mode-alist))
(setq auto-mode-alist (cons '("\\.fcm$"   . fortran-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.for$"   . fortran-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.lat$"   . latex-mode)   auto-mode-alist))
(setq auto-mode-alist (cons '("\\.latex$" . latex-mode)   auto-mode-alist))
(setq auto-mode-alist (cons '("\\.txt$"   . text-mode)    auto-mode-alist))
(setq auto-mode-alist (cons '("\\.pc$"    . c-mode)       auto-mode-alist))
(setq auto-mode-alist (cons '("\\.pp$"    . c-mode)       auto-mode-alist))
(setq auto-mode-alist (cons '("\\.xslt$"  . sgml-mode)       auto-mode-alist))
(setq auto-mode-alist (cons '("\\.jl$"    . sawfish-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.sawfish/custom$" . sawfish-mode) auto-mode-alist))
(autoload 'sawfish-mode "sawfish" "Sawmillfish editing mode." t)
(autoload 'javascript-mode "javascript-mode" "JavaScript mode" t)
(autoload 'cobol-mode "cobol-mode" "COBOL mode" t)
(setq auto-mode-alist (append '(("\\.js$" . javascript-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.param$" . perl-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("/DEBIAN/control$" . debian-control-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("/debian/control$" . debian-control-mode)) auto-mode-alist))

(add-hook 'javascript-mode-hook
	  '(lambda()
	     (font-lock-mode)))

;; Settings in Fortran mode
(setq fortran-mode-hook
      '(lambda ()
	 (abbrev-mode 1)
	 (setq comment-start '"!")
	 (auto-fill-mode 1)
	 (set-fill-column 72)
	 (make-variable-buffer-local 'version-control)
	 (setq version-control 1)
	 (setq fortran-check-all-num-for-matching-do 1)
	 (setq fortran-blink-matching-if 1)
	 (setq fortran-do-indent 2)
	 (setq fortran-if-indent 2)
	 (setq truncate-lines 1)
	 (auto-show-mode t)
	 (setq fortran-comment-indent-style 'fixed)
	 (setq fortran-column-ruler
"1   5 7 10        20        30        40        50        60        70
[   ]-{  |    |    |    |    |    |    |    |    |    |    |    |    | }
")
))

(setq java-mode-hook
      '(lambda ()
	 (local-set-key "\C-c\C-c" 'compile)
	 (local-set-key "\C-c\C-r" 'remote-compile)
         (setq indent-tabs-mode t)
	 (setq tab-width 4)
	 (local-set-key "#" 'match-paren)))
(modify-coding-system-alist 'file "\\.java$" 'utf-8)
(modify-coding-system-alist 'file "\\.java.~" 'utf-8)

(setq c-mode-hook
      '(lambda ()
	 (local-set-key "\C-c\C-c" 'compile)
	 (local-set-key "\C-c\C-r" 'remote-compile)
         (setq indent-tabs-mode nil)
	 (setq tab-width 4)
	 (local-set-key "#" 'match-paren)))

(setq c++-mode-hook
      '(lambda ()
	 (local-set-key "\C-c\C-c" 'compile)
	 (local-set-key "\C-c\C-r" 'remote-compile)
         (setq indent-tabs-mode nil)
	 (local-set-key "#" 'match-paren)))

;; Initialize regexp for LaTeX, Texinfo and Fortran files when in outline mode
(setq find-file-hooks
      '((lambda ()
	  (cond ((or (string-match "\\.lat$"   buffer-file-name)
		     (string-match "\\.ltx$" buffer-file-name)
		     (string-match "\\.latex$" buffer-file-name)
		     (string-match "\\.LaTeX$" buffer-file-name))
		 (setq outline-regexp '"\\\\chap\\|\\\\\\(sub\\)*section")) ;"\\\\" matches `\'
		((string-match "\\.texinfo$" buffer-file-name)
		 (setq outline-regexp "@chap\\|@\\(sub\\)*section"))
		((or (string-match "\\.f$"   buffer-file-name)
		     (string-match "\\.fcm$" buffer-file-name)
		     (string-match "\\.for$" buffer-file-name))
		 (setq outline-regexp '"[ \t]+subro\\|[ \t]+call\\|[ \t]+[a-zA-Z]* func\\|[ \t]+exte"))
		((string-match "\\.r$"   buffer-file-name)
		 (local-set-key "\C-c\C-c" 'rlab-file))
))))
(defun rlab-file (file)
  "Run rlab on file."
  (interactive "b")
  (shell-command (concat "rlab " file) ))
(defun rlab-buffer (arg)
  "Run rlab on buffer."
  (interactive "p")
  (shell-command-on-region 1 buffer-saved-size "rlab -mp"))
(defun rlab-region (arg start stop)
  "Run rlab on region."
  (interactive "p\nr")
  (shell-command-on-region start stop "rlab -mp"))

(modify-coding-system-alist 'file "COMMIT_EDITMSG" 'utf-8)
(modify-coding-system-alist 'file "/tmp/mutt-" 'utf-8)
(setq auto-mode-alist (cons '("/tmp/mutt-" . mail-mode) auto-mode-alist))
(setq file-name-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8)

(defun latin (&optional prefix-arg)
  "Revert buffer using ISO-8859-* where ISO-8859-1 is the default
  unless PREFIX-ARG is specified." (interactive "P")
  (let ((revert-without-query '(".*"))
        (arg (or prefix-arg 1))
       (point (point)))
    (revert-buffer-with-coding-system (intern (concat "latin-" (number-to-string arg))))
    (goto-char point)))

(defun latin-1 ()
  "Revert buffer using ISO-8859-1" (interactive)
  (let ((revert-without-query '(".*"))
       (point (point)))
    (revert-buffer-with-coding-system 'latin-1)
    (goto-char point)))

(defun latin-9 ()
  "Revert buffer using ISO-8859-15" (interactive)
  (let ((revert-without-query '(".*"))
       (point (point)))
    (revert-buffer-with-coding-system 'latin-9)
    (goto-char point)))

(defun utf-8 ()
  "Revert buffer using UTF-8" (interactive)
  (let ((revert-without-query '(".*"))
       (point (point)))
    (revert-buffer-with-coding-system 'utf-8)
    (goto-char point)))

(defun dos-mode ()
  "Revert buffer using DOS-mode"
  (interactive)
  (setq inhibit-eol-conversion nil)
  (let ((revert-without-query '(".*"))
        (point (point)))
    (revert-buffer-with-coding-system 'dos)
    (goto-char point)))

(defun unix-mode ()
  "Revert buffer using UNIX-mode"
  (interactive)
  (setq inhibit-eol-conversion t)
  (let ((revert-without-query '(".*"))
       (point (point)))
    (revert-buffer-with-coding-system 'unix)
    (goto-char point)))

(defun hqp ()
  "Alias for hakpar-to-mime-buffer"
  (interactive)
  (hakpar-to-8859-buffer)
  (latin1-to-mime-buffer))
(defun qp ()
  "Alias for latin1-to-mime-buffer"
  (interactive)
  (latin1-to-mime-buffer))
(defun qpl ()
  "Alias for quoted-printable-to-latin1-buffer"
  (interactive)
  (if buffer-read-only (toggle-read-only))
  (quoted-printable-to-latin1-buffer)
  (goto-char (point-min))
  (while
      (re-search-forward "^.................................................................................." nil t)
    (fill-paragraph nil)
    )
  (toggle-read-only 1))
;(defun emil ()
;  "Run emil coversion on buffer"
;  (interactive)
;  (shell-command-on-region (point-min) (point-max) "emil -G mime_user" nil 1))
(defun man-file (file)
  "Open a manual page specified by its path."
  (interactive "fMan page: ")
  (manual-entry (concat "-l " file))
  )

;; Perform mode specific initializations for *new* files.
(setq find-file-not-found-hooks
      '((lambda ()
	  (cond ((or (string-match "\\.c$" buffer-file-name)
		     (string-match "\\.h$" buffer-file-name)
		     (string-match "\\.cc$" buffer-file-name))
		 ;;(insert "/*  -*-Mode: c; -*-  */\n")
		 (insert "#include  <ctype.h>\n")
		 (insert "#include  <stdio.h>\n")
		 (insert "#include  <stdlib.h>\n")
		 (insert "#include  <math.h>\n"))
                
                ((string-match "\\.pl$" buffer-file-name)
                 (insert "#!/usr/bin/perl\n")
                 (insert "use strict;\n")
                 (insert "use warnings;\n\n"))

		((or (string-match "\\.tex$" buffer-file-name)
		     (string-match "\\.TeX$" buffer-file-name))
		 (insert "%-*-Mode: tex; -*-\n")
		 (insert "%**start of header\n")
		 ;;(insert "\\input /home/tdb/USER/tex/texdefs\n")
		 (insert "%**end of header\n")
		 (insert "\n\\bye\n")
		 (forward-line -2))
		
                ((string-match "^/tmp/vm-visit-folder\\.\\([^/]*\\)$" buffer-file-name)
                 (let ((tmp-buffer (buffer-name))
		       (folder (concat "~/Mail/" (match-string 1 buffer-file-name))))
		   (if (file-regular-p (concat folder ".gz"))
		       (setq folder (concat folder ".gz")))
		   (load "vm")
                   (vm-visit-folder folder)
                   (kill-buffer tmp-buffer)))
		
		))))

;; Testing:
(defun  scroll-left-right (arg)
  "testing"
  (interactive "P")
  (scroll-left (- (current-column) (/ (frame-width) 2))))
(global-set-key "\eOu" 'scroll-left-right)

;; Customized bindings
(global-set-key "\C-c\C-c" 'compile)
(global-set-key "\C-c\C-r" 'remote-compile)
(global-set-key "\C-cc"  'comment-region)
(global-set-key "\C-\\"  'set-mark-command)
(global-set-key "\C-x6"  'set-mark-command)
(global-set-key "\C-h"   'help-command)
(global-set-key "\C-h"   'delete-backward-char)
(global-set-key "\e]"    'ispell-region)
(global-set-key "\e\""   'ispell-complete-word)
(global-set-key [C-return]   'complete)
(global-set-key "\e\r"   'complete)
(global-set-key "\C-[+"  'help-command)
(global-set-key "\C-[?"  'help-command)
(global-set-key "\C-xh"  'help-for-help) ; overrides mark-whole-buffer
(global-set-key "\C-x\M-e" 'ediff-buffers)
(global-set-key "\C-x\C-\\" 'save-buffer)
(global-set-key "\C-c=" 'count-matches)
(global-set-key [C-tab] 'goto-line)
(global-set-key "\e[D"   'backward-char)
(global-set-key "\e[C"   'forward-char)
(global-set-key "\e[A"   'previous-line)
(global-set-key "\e[B"   'next-line)
(global-set-key "\C-z" 'shell)
(global-set-key "\C-c\C-f" 'find-file-at-point)
(global-set-key "\C-x\M-f" 'find-file-literally)
(global-set-key "\C-x\C-m\C-b" 'menu-bar-mode)
(if (>= emacs-major-version 20)
    (global-set-key "\C-x\C-m\C-t" 'tool-bar-mode))

;; Customized bindings for stupid terminals
(global-set-key "\eOa"   'backward-paragraph)
(global-set-key "\eOb"   'forward-paragraph)
(global-set-key "\eOd"   'backward-word)
(global-set-key "\eOc"   'forward-word)
(global-set-key "\e[1~"   'beginning-of-buffer)
(global-set-key "\e[4~"   'end-of-buffer)
(global-set-key [find]   'beginning-of-buffer)
(global-set-key [select] 'end-of-buffer)
(global-set-key [home]   'beginning-of-buffer)
(global-set-key [end]    'end-of-buffer)
(global-set-key "\e[5^"   'scroll-right)
(global-set-key "\e[6^"   'scroll-left)

;; Customized bindings for dired mode
(setq dired-load-hook
	'(lambda() (define-key dired-mode-map "\C-m" 'dired-view-file)))
;;
;;;; Customized Numeric Key Pad (for vt100)
;;(setq term-setup-hook
;;	(function
;;	 (lambda()
;;	   (global-set-key "\eOP" 'overwrite-mode)
;;	   (global-set-key "\eOQ" 'beginning-of-line)
;;	   (global-set-key "\eOR" 'scroll-down)
;;	   (global-set-key "\eOS" 'delete-char)
;;	   (global-set-key "\eOT" 'end-of-line)
;;	   (global-set-key "\eOU" 'scroll-up)
;;	   (global-set-key "\eOl" "+")
;;	   (global-set-key "\eOm" "-")
;;	   (global-set-key "\eOn" 'kill-rectangle)
;;	   (global-set-key "\eOi" 'goto-line)
;;	   (global-set-key "\eOp" 'yank-rectangle)
;;	   (global-set-key "\eOq" 'end-of-buffer)
;;	   (global-set-key "\eOr" 'next-line-recenter)
;;	   (global-set-key "\eOs" 'scroll-up-recenter)
;;	   (global-set-key "\eOt" 'backward-scroll)
;;	   (global-set-key "\eOu" 'resenter)
;;	   (global-set-key "\eOv" 'forward-scroll)
;;	   (global-set-key "\eOw" 'beginning-of-buffer)
;;	   (global-set-key "\eOx" 'previous-line-recenter)
;;	   (global-set-key "\eOy" 'scroll-down-recenter)
;;	   )))
;;
;;(defun  resenter (arg)
;;  "Scroll left one screen and recenter"
;;  (interactive "p")
;;  (scroll-right (frame-width))
;;  (recenter))
;;(defun  scroll-down-recenter (arg)
;;  "Scroll down and recenter"
;;  (interactive "p")
;;  (scroll-down)
;;  (recenter))
;;(defun  scroll-up-recenter (arg)
;;  "Scroll up and recenter"
;;  (interactive "p")
;;  (scroll-up)
;;  (recenter))
;;(defun  next-line-recenter (arg)
;;  "Go to next line and recenter"
;;  (interactive "p")
;;  (next-line (or arg 1))
;;  (recenter))
;;(defun  previous-line-recenter (arg)
;;  "Go to previous line and recenter"
;;  (interactive "p")
;;  (previous-line (or arg 1))
;;  (recenter))
;;(defun  forward-scroll (arg)
;;  "Go forward one character and scroll left"
;;  (interactive "p")
;;  (forward-char (or arg 1))
;;  (scroll-left (or arg 1)))
;;(defun  backward-scroll (arg)
;;  "Go backward one character and scroll right"
;;  (interactive "p")
;;  (backward-char (or arg 1))
;;  (scroll-right (or arg 1)))
;;(defun  scroll-max-right (arg)
;;  "Scroll right many screens"
;;  (interactive "p")
;;  (scroll-right (or (* 100 (frame-width)) arg)))
;;
(global-set-key "\C-^" 'toggle-truncate-lines)
(defun  toggle-truncate-lines (arg)
  "Toggle truncate-lines"
  (interactive "P")
  (setq truncate-lines (or arg (not truncate-lines)))
  ;(auto-show-mode t)
  (redraw-display))

(global-set-key "#" 'match-paren)
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert a <key>."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) )
	  ((eq (char-syntax (preceding-char)) ?\)) (backward-list 1))
	  (t (self-insert-command (or arg 1)))))
(show-paren-mode 'on)
;(defun match-paren (arg)
;  "Go to the matching parenthesis if on parenthesis otherwise insert a <key>."
;  (interactive "p")
;  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;	   ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;	   (t (self-insert-command (or arg 1)))))

;;(defun figlet-region (start end font)
;;  "Change characters in between point and mark to figlets."
;;  (interactive "r\nsfont [fuzzy]: ")
;;  (make-variable-buffer-local 'shell-file-name)
;;  (setq shell-file-name "/bin/sh")
;;  (shell-command-on-region
;;   start end
;;   (dired-replace-in-string
;;    "font"
;;    (if (equal font "") "fuzzy" font)
;;    "figlet -f font"
;;    ) t))

;;; Emacs/W3 configuration options
;(require  'w3-auto "w3-auto")
(setq w3-default-homepage "http://www.init.se/~jonas/")
(setq w3-delay-image-loads nil)
;(setq w3-hotlist-file "~/.netscape/bookmarks.html")
(setq url-personal-mail-address "jonas@init.se")
(global-set-key "\C-c\C-u" 'browse-url-at-point)
(global-set-key [S-mouse-2] 'browse-url-at-mouse)
(setq widget-image-auto-retrieve t)
;(setq browse-url-generic-program "firefox")
;(setq browse-url-generic-program "mozilla")
;(setq browse-url-generic-args nil)
;(setq browse-url-generic-program "/usr/bin/galeon")
;(setq browse-url-generic-program "gnome-moz-remote")
;(setq browse-url-generic-args '("--raise" "--newwin"))
;(or (eq window-system 'x)
;    (setq browse-url-browser-function 'browse-url-w3))
;;(setq browse-url-netscape-arguments '("-install"))
;;; End of Emacs-w3 configuration options

;(setq lisp-font-lock-keywords-2 '(("(\\(def\\(\\(advice\\|alias\\|generic\\|macro\\*?\\|method\\|setf\\|subst\\*?\\|un\\*?\\|ine-\\(derived-mode\\|function\\|condition\\|skeleton\\|widget\\|setf-expander\\|method-combination\\|\\(symbol\\|compiler\\|modify\\)-macro\\)\\)\\|\\(const\\(ant\\)?\\|custom\\|face\\|var\\|parameter\\)\\|\\(class\\|group\\|package\\|struct\\|type\\)\\)\\)\\>[ 	'(]*\\(\\sw+\\)?"
;  (1 font-lock-keyword-face)
;  (9
;   (cond
;    ((match-beginning 3)
;     font-lock-function-name-face)
;    ((match-beginning 6)
;     font-lock-variable-name-face)
;    (t font-lock-type-face))
;   nil t))
; ("^;;;###\\(autoload\\)\\>" 1 font-lock-warning-face prepend)
; ("(\\(c\\(atch\\|ond\\(ition-case\\)?\\)\\|eval-\\(a\\(fter-load\\|nd-compile\\)\\|when\\(-compile\\)?\\)\\|i\\(f\\|nline\\)\\|l\\(ambda\\|et\\*?\\)\\|prog[*12nv]?\\|save-\\(current-buffer\\|excursion\\|match-data\\|restriction\\|selected-window\\|window-excursion\\)\\|t\\(hrow\\|rack-mouse\\)\\|unwind-protect\\|w\\(hile\\|ith-\\(current-buffer\\|electric-help\\|output-to-\\(string\\|temp-buffer\\)\\|t\\(emp-\\(buffer\\|file\\)\\|imeout\\)\\)\\)\\)\\>" . 1)
; ("(\\(a\\(bort\\|ssert\\)\\|b\\(lock\\|reak\\)\\|c\\(ase\\|case\\|error\\|ompiler-let\\|typecase\\)\\|d\\(e\\(cla\\(im\\|re\\)\\|structuring-bind\\)\\|o\\(\\*\\|list\\|times\\)?\\)\\|e\\(case\\|rror\\|typecase\\)\\|flet\\|handler-\\(bind\\|case\\)\\|i\\(gnore-errors\\|n-package\\)\\|l\\(abels\\|exical-let\\*?\\|o\\(cally\\|op\\)\\)\\|macrolet\\|proclaim\\|re\\(start-\\(bind\\|case\\)\\|turn\\(-from\\)?\\)\\|symbol-macrolet\\|t\\(agbody\\|he\\|ypecase\\)\\|unless\\|when\\)\\>" . 1)
; ("(\\(featurep\\|provide\\|require\\)\\>[ 	']*\\(\\sw+\\)?"
;  (1 font-lock-keyword-face)
;  (2 font-lock-constant-face nil t))
; ("\\\\\\\\\\[\\(\\sw+\\)]" 1 font-lock-constant-face prepend)
; ("`\\(\\sw\\sw+\\)'" 1 font-lock-constant-face prepend)
; ("\\<:\\sw\\sw+\\>" 0 font-lock-builtin-face)
; ("\\<\\&\\sw+\\>" . font-lock-type-face)
;   ("font-lock-\\(builtin\\)-face" 1 font-lock-builtin-face)
;   ("font-lock-\\(comment\\)-face" 1 font-lock-comment-face)
;   ("font-lock-\\(function-name\\)-face" 1 font-lock-function-name-face)
;   ("font-lock-\\(keyword\\)-face" 1 font-lock-keyword-face)
;   ("font-lock-\\(constant\\)-face" 1 font-lock-constant-face)
;   ("font-lock-\\(reference\\)-face" 1 font-lock-reference-face)
;   ("font-lock-\\(string\\)-face" 1 font-lock-string-face)
;   ("font-lock-\\(type\\)-face" 1 font-lock-type-face)
;   ("font-lock-\\(variable-name\\)-face" 1 font-lock-variable-name-face)
;   ))

(defun uidpwd (&optional id)
  (shell-command-to-string
   (concat "uidpwd ybsql " (number-to-string id))))

;; Oracle SQL settings
(defun ora-expl-on-region (start end)
  "Explains the Oracle SQL-Statement found within region."
  (interactive "r")
  (shell-command-on-region start end "/u/ext/lebo/bin/ora_expl"))
(define-key global-map "\M-o" 'ora-expl-on-region)
(autoload 'sqlplus "sql-mode"
  "Run an interactive SQL*plus session in a separate buffer." t)
(autoload 'sql-mode "sql-mode"
  "Major mode for editing SQL*plus batch files." t)
(setq auto-mode-alist (cons '("\\.sql$" . sql-mode) auto-mode-alist))
;(setq sqlplus-username-password (uidpwd 0))
(setq sqlplus-keep-history t)
(setq sqlplus-lines-to-keep 5000)

(add-hook 'sql-mode-hook
	  '(lambda()
	     (abbrev-mode -1)
             (setq tab-width 4)
	     (font-lock-mode t)))

(defun sql= (&optional prefix-arg)
  "Start sqlplus. Without prefix-arg, first ask for user/password pair."
  (interactive "P")
  (sql+ prefix-arg)
)
(defun sql+ (&optional prefix-arg)
  "Start sqlplus. Without prefix-arg, first ask for user/password pair."
  (interactive "P")
  (let ((sqlplus-buffer (get-buffer "*sqlplus*")))
    (if sqlplus-buffer
        (pop-to-buffer sqlplus-buffer)
      (load "sql-mode")
      (defun sqlplus-start ()
        "Start up an interactive SQL*Plus session in a new buffer."
        (let ((sqlplus-buffer (get-buffer-create "*sqlplus*"))
              (sqlplus-sid
               (if (string-match "@\\(.+\\)$" sqlplus-username-password)
                   (match-string 1 sqlplus-username-password)
                 "-"))
              (sqlplus-uid
               (if (string-match "^\\(.+\\)/\\(.+\\)?@" sqlplus-username-password)
                   (match-string 1 sqlplus-username-password)
                 "-"))
              process)
          (setq process			; set process
                (or                    ; to the first that is non-nil:
                 (get-buffer-process sqlplus-buffer) ; current process
                 (progn                 ; or new process
                   (set-buffer sqlplus-buffer)
                   (insert sqlplus-startup-message)
                   (start-process "SQL*plus" sqlplus-buffer "sqlplus"
                                  sqlplus-username-password
                                  "@$HOME/.sqlplusrc"
                                  (concat sqlplus-uid "_" sqlplus-sid))
                   )))
          (set-buffer sqlplus-buffer)
          (cd "~/")
          (goto-char (point-max))
          (set-marker (process-mark process) (point))
          (sqlplus-mode)
          process)) ; return process
      (if prefix-arg
          (if (numberp prefix-arg)
              (setq sqlplus-username-password (uidpwd (abs prefix-arg)))))
      (if (or (not prefix-arg)
              (and (numberp prefix-arg)
                   (<= 0 prefix-arg)))
          (setq sqlplus-username-password
                (read-from-minibuffer "uidpwd: " sqlplus-username-password)))
      (sqlplus))))

(defun sqlplus-del ()
  "Enable exit by \C-d."
  (interactive)
  (if (and (eq (point) (point-max))
	      (search-backward "SQL> " (- (point) 5) t))
        (and (sqlplus-save-session "~/.sqlhist")
	        (kill-buffer nil))
    (delete-char 1)
    ))

(setq sqlplus-mode-hook
      '(lambda()
	 (abbrev-mode -1)
	 (setq tab-width 8)
	 (toggle-truncate-lines t)
	 (setq sql-prompt (concat "^\\(\\([A-Za-z0-9_]+ \\)?SQL> \\)+"))
	 (define-key sqlplus-mode-map [C-up] 'sqlplus-previous-command)
	 (define-key sqlplus-mode-map [C-down] 'sqlplus-next-command)
	 (define-key sqlplus-mode-map [C-S-up] 'sqlplus-back-command)
	 (define-key sqlplus-mode-map [C-S-down] 'sqlplus-forward-command)
	 (define-key sqlplus-mode-map "\e[a" 'sqlplus-back-command)
	 (define-key sqlplus-mode-map "\e[b" 'sqlplus-forward-command)
	 (define-key sqlplus-mode-map "\eOa" 'sqlplus-previous-command)
	 (define-key sqlplus-mode-map "\eOb" 'sqlplus-next-command)
	 (define-key sqlplus-mode-map "\C-d" 'sqlplus-del)
	 ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BUFFER SWITCHING FIX
;;
;; This changes the behaviour of the switch-to-buffer completion functions so
;; that the current buffer is NOT in the completion list.
;;
;; i.e. say you're working in "temp.c", and you want to visit "temp.h"; so you
;; type "C-xb", then "t<TAB>" which then presents you with a completion list of
;; temp.c and temp.h, so you then must type "h<RET>".  This is annoying since
;; why would you want to switch back to the buffer you're in?!?
;; Using this fix would remove "temp.c" from the completion lits so that when
;; you had typed "t<TAB>" the name would be completed as "temp.h" as desired.
;;
;; Steve Dodd
;; March 1998
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun s-minibuffer-complete ()
  "A shell around minibuffer-complete which removes the name of the current buffer from the buffer completion list.  The default behaviour doesn't make sense since there is no reason to ask to switch to the buffer you are already in!"
  (interactive)
  (if s-remove-first-completion
      (progn (setq s-remove-first-completion nil)
	     (if (consp minibuffer-completion-table)
		 (setq  minibuffer-completion-table
			(cdr minibuffer-completion-table)) ()))
    ())
  (minibuffer-complete))

(defun s-minibuffer-complete-word ()
  "A shell around minibuffer-complete-word which removes the name of the current buffer from the buffer completion list.  The default behaviour doesn't make sense since there is no reason to ask to switch to the buffer you are already in!"
  (interactive)
  (if s-remove-first-completion
      (progn (setq s-remove-first-completion nil)
	     (if (consp minibuffer-completion-table)
		 (setq  minibuffer-completion-table
			(cdr minibuffer-completion-table)) ()))
    ())
  (minibuffer-complete-word)
)

(defun s-minibuffer-complete-and-exit ()
  "A shell around minibuffer-complete-and-exit which removes the name of the current buffer from the buffer completion list.  The default behaviour doesn't make sense since there is no reason to ask to switch to the buffer you are already in!"
  (interactive)
  (if s-remove-first-completion
      (progn (setq s-remove-first-completion nil)
	     (if (consp minibuffer-completion-table)
		 (setq  minibuffer-completion-table
			(cdr minibuffer-completion-table)) ()))
    ())
  (minibuffer-complete-and-exit))


(defun s-switch-to-buffer ()
  "A shell around switch-to-buffer which removes the name of the current buffer from the buffer completion list.  The default behaviour doesn't make sense since there is no reason to ask to switch to the buffer you are already in!"
  (interactive)
  (setq s-remove-first-completion 't)
  (switch-to-buffer (read-buffer "Switch to buffer: " (other-buffer))))

(setq s-remove-first-completion nil)

(define-key minibuffer-local-completion-map "\040" 's-minibuffer-word)
(define-key minibuffer-local-completion-map "\t" 's-minibuffer-complete)
(define-key minibuffer-local-must-match-map [return] 's-minibuffer-complete-and-exit)
(global-set-key "\C-xb" 's-switch-to-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END OF BUFFER SWITCHING FIX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun cal-mode () "Font-lock mode for cal-output." (interactive)
  (turn-on-font-lock)
  (make-local-variable 'font-lock-keywords)
  (setq font-lock-keywords cal-font-lock-keywords)
)

(setq auto-mode-alist (cons '("cal.dat" . cal-mode) auto-mode-alist))

(setq cal-font-lock-keywords
      '(
	("^.* +\\([ 1-9][0-9]:\\) \\(.*\\)$"
	 (1 font-lock-type-face)
	 (2 font-lock-comment-face)
	 )
	("^ \\(Sö \\)?Må Ti On To Fr Lö\\( Sö\\)?"
	 (0 font-lock-function-name-face)
	 )
	("^ \\([ 123][ 0-9][< >]\\)+"
	 (0 font-lock-constant-face)
	 )
	("^ [ 0-9]*\\(<[ 123][0-9]>\\)[ 0-9]*"
	 (1 font-lock-comment-face t prepend)
	 )
	("^ *\\([JFMASOND][a-z]* [12][0-9][0-9][0-9]\\)"
	 (1 font-lock-variable-name-face)
	 )
	))

(setq load-path (cons "~/ruby-mode" load-path))
(setq auto-mode-alist (cons '("\\.rb$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("Vagrantfile" . ruby-mode) auto-mode-alist))
(autoload 'ruby-mode "ruby-mode" "Ruby editing mode." t)
(setq ruby-insert-encoding-magic-comment nil)

(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode) interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

(setq org-agenda-include-diary t)
(setq org-agenda-files (list "~/TODO"))
(setq org-log-done 'note)
(global-set-key "\C-ca" 'org-agenda)

;; Display time, process and mail info.
(setq display-time-day-and-date t)
(display-time)

;enable-multibyte-characters or set-buffer-multibyte
; (enable-multibyte-characters t)

(defalias 'perl-mode 'cperl-mode)
;(load "clearcase")
;(define-key clearcase-prefix-map "e" 'clearcase-ediff-named-version-current-buffer)

;(require 'evernote-mode)
;(setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8"))
;(global-set-key "\C-cec" 'evernote-create-note)
;(global-set-key "\C-ceo" 'evernote-open-note)
;(global-set-key "\C-ces" 'evernote-search-notes)
;(global-set-key "\C-ceS" 'evernote-do-saved-search)
;(global-set-key "\C-cew" 'evernote-write-note)
;(global-set-key "\C-cep" 'evernote-post-region)
;(global-set-key "\C-ceb" 'evernote-browser)
;;(setq evernote-username "jonas640")
;(setq evernote-username "jonas@init.se")
;;(setq evernote-developer-token "S=s415:U=45cfd7a:E=14da4307fe3:C=1464c7f53e6:P=1cd:A=en-devtoken:V=2:H=a9840128022a1144a25edb3ce7c7cdf7")

(set-frame-font "Droid Sans Mono 8" nil t)

; OS X
;(set-frame-font "Monaco 11" nil t)
(global-set-key (kbd "s-q") '(lambda () (interactive) (message "Use 'M-x please-save-buffers-kill-emacs' to exit.")))
(global-set-key (kbd "s-w") 'kill-ring-save)
(global-set-key (kbd "s-d") 'kill-word)
(global-set-key (kbd "s-x") 'execute-extended-command)
(global-set-key (kbd "s-+") 'text-scale-adjust)
(global-set-key (kbd "s--") 'text-scale-adjust)
(global-set-key (kbd "s-0") 'text-scale-adjust)
(global-set-key (kbd "s-<backspace>") 'backward-kill-word)
(global-set-key (kbd "C-x s-e") 'ediff-buffers)

(global-set-key (kbd "C-+") 'text-scale-adjust)
(global-set-key (kbd "C--") 'text-scale-adjust)

; load elpa packages
(setq package-enable-at-startup nil)
(package-initialize)
(require 'undo-tree)
(global-undo-tree-mode)

(if (< emacs-major-version 20)
    (setq jl-eof 17)

  (setq custom-file "~/.emacs")

  (custom-set-variables
   '(ange-ftp-try-passive-mode t)
   '(backup-inhibited 1)
   '(browse-url-new-window-flag 1)
   '(c-offsets-alist (quote ((substatement-open . 0))))
;   '(calendar-date-display-form
;     '((if dayname (concat dayname ", "))
;       (format "%02d/%02d/%4s" (string-to-int day) (string-to-int month) year)))
   '(calendar-holiday-marker (quote holiday-face))
   '(calendar-intermonth-text
     '(propertize
             (format "%2d" (car (calendar-iso-from-absolute (calendar-absolute-from-gregorian (list month day year)))))
             (quote font-lock-face) (quote font-lock-function-name-face)))
   '(calendar-mark-diary-entries-flag t)
   '(calendar-mark-holidays-flag t)
   '(calendar-today-marker (quote calendar-today-face))
   '(calendar-today-visible-hook (quote (calendar-mark-today)))
   '(calendar-week-start-day 1)
   '(column-number-mode t)
;   '(default-enable-multibyte-characters nil)
   '(cperl-close-paren-offset -4)
   '(cperl-continued-statement-offset 4)
   '(cperl-indent-level 4)
   '(cperl-indent-parens-as-block t)
   '(default-fill-column 70 t)
   '(diary-display-function (quote (fancy-diary-display)))
   '(diary-display-hook (quote (fancy-diary-display)))
   '(diary-list-include-blanks t)
   '(ediff-window-setup-function (quote ediff-setup-windows-plain))
   '(european-calendar-style t)
   '(indent-tabs-mode nil)
   '(inhibit-eol-conversion t)
   '(inhibit-startup-screen t)
   '(inhibit-splash-screen t)
   '(iso-accents-mode nil)
   '(mark-diary-entries-in-calendar t)
   '(mark-even-if-inactive t)
   '(mark-holidays-in-calendar t)
   '(mouse-yank-at-point t)
   '(perl-indent-level 4)
   '(rst-level-face-base-color "grey")
   '(rst-level-face-base-light 30)
   '(rst-level-face-step-light -5)
   '(show-trailing-whitespace nil)
   '(tex-dvi-view-command "xdvi")
   '(today-visible-calendar-hook (quote (calendar-mark-today)))
   '(track-eol t)
   '(transient-mark-mode t)
   '(twittering-icon-mode t)
   '(woman-bold-face (quote woman-bold-face))
   '(woman-italic-face (quote woman-italic-face))
   '(x-select-enable-primary t)
   )

  (custom-set-faces
   ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
   ;; Your init file should contain only one such instance.
   '(calendar-today-face ((t (:bold t))))
   '(calendar-week-face ((t (:foreground "wheat" :slant italic))))
   '(cperl-array-face ((((class color) (background dark)) (:foreground "yellow"))))
   '(cperl-hash-face ((((class color) (background dark)) (:foreground "Red"))))
   ;'(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 158 :width normal :foundry "unknown" :family "Droid Sans Mono"))))
   '(fringe ((t (:inverse-video nil :background "#400" :foreground "wheat"))))
   '(holiday-face ((((class color)) (:background "red4"))))
   '(modeline ((t (:inverse-video nil :foreground "red4" :background "wheat"))))
   '(woman-bold-face ((t (:foreground "Aquamarine"))) t)
   '(woman-italic-face ((t (:italic t :foreground "OrangeRed"))) t)
   )

  (setq jl-eof 42))

(load "calendar")

(defun holiday-easter-mine ()
  "List of dates related to Easter, as visible in calendar window."
   (let* ((century (1+ (/ displayed-year 100)))
          (shifted-epact        ;; Age of moon for April 5...
           (% (+ 14 (* 11 (% displayed-year 19));;     ...by Nicaean rule
                 (-           ;; ...corrected for the Gregorian century rule
                  (/ (* 3 century) 4))
                 (/    ;; ...corrected for Metonic cycle inaccuracy.
                  (+ 5 (* 8 century)) 25)
                 (* 30 century));;              Keeps value positive.
              30))
          (adjusted-epact       ;;  Adjust for 29.5 day month.
           (if (or (= shifted-epact 0)
                   (and (= shifted-epact 1) (< 10 (% displayed-year 19))))
               (1+ shifted-epact)
             shifted-epact))
          (paschal-moon       ;; Day after the full moon on or after March 21.
           (- (calendar-absolute-from-gregorian (list 4 19 displayed-year))
              adjusted-epact))
          (abs-easter (calendar-dayname-on-or-before 0 (+ paschal-moon 7))))
     (filter-visible-calendar-holidays
      (list
       (list (calendar-gregorian-from-absolute (- abs-easter 47))
             "Fettisdag")
       (list (calendar-gregorian-from-absolute (- abs-easter 2))
             "L\ångfredag")
       (list (calendar-gregorian-from-absolute abs-easter)
             "P\åsk")
       (list (calendar-gregorian-from-absolute (+ abs-easter 1))
             "Annandag p\åsk")
       (list (calendar-gregorian-from-absolute (+ abs-easter 39))
             "Kristi himmelf\ärdsdag")
       (list (calendar-gregorian-from-absolute (+ abs-easter 49))
             "Pingst")
       ;;(list (calendar-gregorian-from-absolute (+ abs-easter 50))
       ;;      "Annandag pingst")
       ))))


(setq my-calendar-holidays
      '(
        (holiday-fixed 1 1 "Ny\årsdagen")
        (holiday-fixed 1 6 "Trettondedag jul")
        (holiday-easter-mine)
        (holiday-fixed 4 30 "Sista april")
        (holiday-fixed 5 1 "F\örsta maj")
        (holiday-fixed 6 6 "Sveriges nationaldag")
        (holiday-float 6 5 1 "Midsommarafton" 19)
        (holiday-float 6 6 1 "Midsommar" 20)
        (holiday-float 10 6 1 "Alla helgons dag" 31)
        (holiday-fixed 12 13 "Lucia")
        (holiday-fixed 12 24 "Julafton")
        (holiday-fixed 12 25 "Juldagen")
        (holiday-fixed 12 26 "Annandag jul")
        (holiday-fixed 12 31 "Ny\årsafton")
        ))
(setq calendar-holidays
      (append my-calendar-holidays holiday-solar-holidays))

(defun calendar-week (&optional odate)
  "Print week number between 0 and 53. Week 1 is the first week with
 at least four days in the new year."
  (interactive)
  (let* ((date (or odate (calendar-cursor-to-date t)))
         (number (calendar-day-number date))
         (first (calendar-day-of-week `(1 1 ,(extract-calendar-year date))))
         (dividend (cond
                    ((> first 4) (- number (- 9 first))) ; Friday-Saturday
                    ((zerop first) (- number 2)) ; Sunday
                    (t (+ number (- first 2))) ; Monday-Thursday
                    )))
    (if (< dividend 0) (setq dividend (- dividend 7))) ; Week 0
    (if odate
        (1+ (/ dividend 7))
      (message (concat "Week: " (int-to-string (1+ (/ dividend 7))))))
    ))

;;(defun generate-calendar-month (month year indent) ; /usr/share/emacs/22.3/lisp/calendar/calendar.el.gz
; (calendar-insert-indented "wk " (- indent 3))(overlay-put (make-overlay (- (point) 3) (1- (point))) 'face 'calendar-week-face);; Go to proper spot
; (calendar-insert-indented (format "%2d " (calendar-week (list month 1 year))) (- indent 3))(overlay-put (make-overlay (- (point) 3) (1- (point))) 'face 'calendar-week-face);; Go to proper spot
; (calendar-insert-indented (format "%2d " (calendar-week (list month (1+ i) year))) (- indent 3))(overlay-put (make-overlay (- (point) 3) (1- (point))) 'face 'calendar-week-face)))));; Go to proper spot

;(add-hook 'diary-hook 'appt-make-list)
(add-hook 'list-diary-entries-hook 'sort-diary-entries t)
(setq diary-display-function 'diary-fancy-display)
(setq diary-list-entries-hook 'diary-include-other-diary-files)
(setq diary-mark-entries-hook 'diary-mark-included-diary-files)
;function `include-other-diary-files' as part of `list-diary-entries-hook'."
(setq view-diary-entries-initially nil)
(setq cal-tex-diary t)
(setq calendar-latitude [59 51 north])
(setq calendar-longitude [17 37 east])
(setq calendar-location-name "Eriksberg/Uppsala")
(define-key calendar-mode-map [return] 'diary-view-entries)
(define-key calendar-mode-map "w" 'calendar-week)
(defun appt-nil () "Delete appt-mode message." (interactive)(setq appt-mode-string nil))
(defface calendar-week-face nil nil)
(or (eq window-system 'x) (set-face-background 'holiday-face "blue"))
(calendar)

;;;                        |||  Type "C-x C-e" to update!
;;;                        vvv
;;; (load "~/.emacs" nil t) 
;;; (eval-buffer) 
