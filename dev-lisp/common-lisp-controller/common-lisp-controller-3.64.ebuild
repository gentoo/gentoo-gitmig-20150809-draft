# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/common-lisp-controller/common-lisp-controller-3.64.ebuild,v 1.8 2003/12/14 22:38:07 spider Exp $

DESCRIPTION="Common Lisp Controller"
HOMEPAGE="http://packages.debian.org/unstable/devel/common-lisp-controller.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/common-lisp-controller/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"

DEPEND="netkit-base
	dev-lisp/cl-defsystem3
	dev-lisp/cl-asdf
	app-admin/realpath"

src_compile() {
	make || die
}

src_install() {
	dobin clc-autobuild* \
		clc-register-user-package \
		clc-send-command \
		clc-unregister-user-package

	dosbin clc-build-daemon \
		clc-reregister-all-impl \
		register-common-lisp-source \
		register-common-lisp-implementation \
		unregister-common-lisp-source \
		unregister-common-lisp-implementation

	exeinto /usr/lib/common-lisp-controller
	doexe debug-daemon-problems.sh

	dodir /usr/share/common-lisp/source/common-lisp-controller
	insinto /usr/share/common-lisp/source/common-lisp-controller
	doins common-lisp-controller.lisp \
		post-sysdef-install.lisp \
		pre-sysdef-install.lisp

	dodir /usr/lib/common-lisp
	dodir /usr/lib/common-lisp/bin

	dodir /etc/common-lisp
	touch ${D}/etc/common-lisp/autobuild # autobuild by default

	dodoc *.txt README.*
	doman man/*.1 man/*.8 man/old/*.1 man/old/*.8

	einfo ">>> Creating /etc/lisp-config.lisp"
	dodir /etc
	cat >${D}/etc/lisp-config.lisp <<EOF
(in-package :common-lisp-user)
#+(or cmu scl) (setf system:*short-site-name* "Unknown" system:*long-site-name* "Unknown")
#+sbcl (setf sb-sys:*short-site-name* "Unknown" sb-sys:*long-site-name* "Unknown")
EOF
}

pkg_postinst() {
	einfo ">>> Creating cl-builder user and group if necessary"
	getent group cl-builder >/dev/null || \
		groupadd cl-builder
	getent passwd cl-builder >/dev/null || \
		useradd -g cl-builder -s /bin/false cl-builder

	einfo ">>> Setting permissions for cl-builder"
	for compiler in /usr/lib/common-lisp/bin/*.sh
	do
		if [ -f "$compiler" -a -r "$compiler}" ] ; then
			i=${compiler##*/}
			i=${i%.sh}
			chown -R cl-builder:cl-builder /usr/lib/common-lisp/${i} >/dev/null || true
		fi
	done

	einfo ">>> You must execute:"
	einfo ">>> ebuild /var/db/pkg/dev-lisp/${PF}/${PF}.ebuild config"
	einfo ">>> to add the common-lisp-controller builder to /etc/inetd.conf"
}

pkg_config() {
	local inetd_line=`echo -e "8990\tstream\ttcp\tnowait.400\troot\t/usr/sbin/clc-build-daemon\tclc-build-daemon"`
	einfo ">>> Checking for an existing inetd.conf entry"
	if [ -f /etc/inetd.conf ] && grep "$inetd_line" /etc/inetd.conf >/dev/null ; then
		einfo ">>> Found existing entry. Nothing to do."
	else
		einfo "Appending common-lisp-controller builder to /etc/inetd.conf"
		echo "$inetd_line" >>/etc/inetd.conf || die "Cannot append to inetd.conf"
		einfo "Restart /etc/init.d/inetd to apply changes."
	fi
}


### from debian's postinst script:

#     abort-upgrade|abort-remove|abort-deconfigure)
#         update-inetd --remove "8990@localhost\tstream\ttcp\tnowait\troot\t/usr/sbin/clc-build-daemon"
# 	for compiler in /usr/lib/common-lisp/bin/*.sh ; do
# 	    if [ -f "$compiler" -a -r "$compiler" ] ; then
# 	     i=${compiler##*/}
# 	     i=${i%.sh}
# 	     if [ -x "$compiler" ] ; then
# 	        echo Deinstalling for ${i##*/}
# 	        echo Removing Common Lisp Controller for $i
# 	        bash "$compiler" remove-clc || true
# 	        echo
# 	        echo Done rebuilding
# 	    fi
# 	   fi
# 	 done
#     ;;
