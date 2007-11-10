# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-baselibs/emul-linux-x86-baselibs-11.0.ebuild,v 1.1 2007/11/10 03:58:29 kingtaco Exp $

inherit emul-libs

SRC_URI="mirror://gentoo/binutils-2.18-r1.tbz2
		mirror://gentoo/bzip2-1.0.4.tbz2
		mirror://gentoo/com_err-1.40.2.tbz2
		mirror://gentoo/cracklib-2.8.10.tbz2
		mirror://gentoo/cups-1.2.12-r2.tbz2
		mirror://gentoo/db-4.5.20_p2.tbz2
		mirror://gentoo/dbus-1.0.2-r2.tbz2
		mirror://gentoo/dbus-glib-0.73.tbz2
		mirror://gentoo/dbus-qt3-old-0.70.tbz2
		mirror://gentoo/e2fsprogs-1.40.2.tbz2
		mirror://gentoo/expat-2.0.1.tbz2
		mirror://gentoo/file-4.21-r1.tbz2
		mirror://gentoo/gamin-0.1.9.tbz2
		mirror://gentoo/gdbm-1.8.3-r3.tbz2
		mirror://gentoo/giflib-4.1.4.tbz2
		mirror://gentoo/glib-1.2.10-r5.tbz2
		mirror://gentoo/glib-2.12.13.tbz2
		mirror://gentoo/gpm-1.20.1-r5.tbz2
		mirror://gentoo/jpeg-6b-r7.tbz2
		mirror://gentoo/lcms-1.15.tbz2
		mirror://gentoo/libart_lgpl-2.3.19-r1.tbz2
		mirror://gentoo/libidn-0.6.9-r1.tbz2
		mirror://gentoo/libmng-1.0.9-r1.tbz2
		mirror://gentoo/libperl-5.8.8-r1.tbz2
		mirror://gentoo/libpng-1.2.22.tbz2
		mirror://gentoo/libtool-1.5.24.tbz2
		mirror://gentoo/libxml2-2.6.28.tbz2
		mirror://gentoo/ncurses-5.6-r1.tbz2
		mirror://gentoo/nss_ldap-253.tbz2
		mirror://gentoo/openldap-2.3.38.tbz2
		mirror://gentoo/openssl-0.9.8g.tbz2
		mirror://gentoo/pam-0.99.8.1-r1.tbz2
		mirror://gentoo/pwdb-0.62.tbz2
		mirror://gentoo/readline-5.2_p7.tbz2
		mirror://gentoo/slang-1.4.9-r2.tbz2
		mirror://gentoo/ss-1.40.2.tbz2
		mirror://gentoo/tiff-3.8.2-r2.tbz2
		mirror://gentoo/zlib-1.2.3-r1.tbz2"


LICENSE="|| ( Artistic GPL-2 ) || ( BSD GPL-2 ) BZIP2 CRACKLIB DB
		GPL-2 || ( GPL-2 AFL-2.1 ) LGPL-2 LGPL-2.1 MIT OPENLDAP openssl
		PAM ZLIB as-is"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="!<app-emulation/emul-linux-x86-medialibs-10.2" # bug 168507

src_unpack() {
	export ALLOWED="(${S}/lib32/security/pam_filter/upperLOWER|${S}/etc/env.d)"
	emul-libs_src_unpack
	rm -rf "${S}/etc/env.d/binutils/" \
			"${S}/usr/lib32/binutils/" \
			"${S}/usr/lib32/engines/" \
			"${S}/usr/lib32/openldap/" \
			"${S}/usr/lib32/python2.4/"

	ln -s ../share/terminfo "${S}"/usr/lib32/terminfo
}
