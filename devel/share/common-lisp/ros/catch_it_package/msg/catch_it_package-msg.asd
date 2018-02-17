
(cl:in-package :asdf)

(defsystem "catch_it_package-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Target_pos" :depends-on ("_package_Target_pos"))
    (:file "_package_Target_pos" :depends-on ("_package"))
  ))