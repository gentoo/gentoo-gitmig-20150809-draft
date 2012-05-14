# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-baselibs/emul-linux-x86-baselibs-20120127-r1.ebuild,v 1.1 2012/05/14 20:39:10 ssuominen Exp $

EAPI="4"

inherit emul-linux-x86

LICENSE="|| ( Artistic GPL-2 ) || ( BSD GPL-2 ) BZIP2 CRACKLIB DB
		GPL-2 || ( GPL-2 AFL-2.1 ) LGPL-2 LGPL-2.1 GPL-3 LGPL-3
		MIT MPL-1.1 OPENLDAP OpenSoftware openssl OracleDB ZLIB
		tcp_wrappers_license as-is UoI-NCSA wxWinLL-3.1"
KEYWORDS="-* ~amd64"

DEPEND=""
RDEPEND="!<app-emulation/emul-linux-x86-medialibs-10.2" # bug 168507

QA_DT_HASH="usr/lib32/.*"

PYTHON_UPDATER_IGNORE="1"

src_prepare() {
	export ALLOWED="(${S}/lib32/security/pam_filter/upperLOWER|${S}/etc/env.d|${S}/lib32/security/pam_ldap.so)"
	emul-linux-x86_src_prepare
	rm -rf "${S}/etc/env.d/binutils/" \
			"${S}/usr/i686-pc-linux-gnu/lib" \
			"${S}/usr/lib32/engines/" \
			"${S}/usr/lib32/openldap/" || die

	ln -s ../share/terminfo "${S}/usr/lib32/terminfo" || die
}

src_install() {
	emul-linux-x86_src_install

	# http://bugs.gentoo.org/415997
	dosym libtiff$(get_libname 3) /usr/lib32/libtiff$(get_libname 4)
	dosym libtiffxx$(get_libname 3) /usr/lib32/libtiffxx$(get_libname 4)
}
