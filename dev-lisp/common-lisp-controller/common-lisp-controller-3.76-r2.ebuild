# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/common-lisp-controller/common-lisp-controller-3.76-r2.ebuild,v 1.1 2003/12/21 19:58:17 mkennedy Exp $

DESCRIPTION="Common Lisp Controller"
HOMEPAGE="http://packages.debian.org/unstable/devel/common-lisp-controller.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/common-lisp-controller/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~mips"

DEPEND="dev-lisp/cl-defsystem3
	dev-lisp/cl-asdf
	app-admin/realpath
	virtual/logger"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-coreutils-gentoo.patch
}

src_install() {
	dobin clc-autobuild* \
		clc-register-user-package \
		clc-unregister-user-package

	dobin ${FILESDIR}/clc-send-command
#	newsbin clc-build-daemon-standalone clc-build-daemon

	dosbin 	clc-reregister-all-impl \
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
	doman man/*.1 man/*.8 man/old/*.1

	einfo ">>> Creating /etc/lisp-config.lisp"
	dodir /etc
	cat >${D}/etc/lisp-config.lisp <<EOF
(in-package :common-lisp-user)
#+(or cmu scl) (setf system:*short-site-name* "Unknown" system:*long-site-name* "Unknown")
#+sbcl (setf sb-sys:*short-site-name* "Unknown" sb-sys:*long-site-name* "Unknown")
EOF

	dodoc ${FILESDIR}/README.Gentoo
	insinto /usr/share/doc/${PF}/inetd-examples
	doins ${FILESDIR}/{inetd.conf-snippet,clc-build-daemon}

	keepdir /usr/lib/common-lisp /usr/lib/common-lisp/bin
}

pkg_postinst() {
	userdel cl-builder &>/dev/null || true
	groupdel cl-builder &>/dev/null || true
	enewgroup  cl-builder
	enewuser cl-builder -1 /bin/sh /usr/lib/common-lisp cl-builder
	chown root:root /usr/lib/common-lisp

	for compiler in /usr/lib/common-lisp/bin/*.sh
	do
		if [ -f "${compiler}" -a -r "${compiler}" -a -x "${compiler}" ] ; then
			i=${compiler##*/}
			i=${i%.sh}
		    einfo ">>> Recompiling Common Lisp Controller for $i"
			bash "$compiler" install-clc || true
		    einfo ">>> Done rebuilding"
			chown -R cl-builder:cl-builder /usr/lib/common-lisp/${i} &>/dev/null || true
		fi
	done
	echo
	while read line; do einfo "${line}"; done <${FILESDIR}/README.Gentoo
}

# pkg_prerm() {
# 	for compiler in /usr/lib/common-lisp/bin/*.sh
# 	do
# 		if [ -f "$compiler" -a -r "$compiler}" ] ; then
# 			i=${compiler##*/}
# 			i=${i%.sh}
# 		    echo Deinstalling for ${i##*/}
# 		    echo Removing Common Lisp Controller for $i
# 			if [ -x "$compiler"] ; then
# 				bash "$compiler" remove-clc || true
# 			fi
# 		    echo Done rebuilding
# 		fi
# 	done
# }
