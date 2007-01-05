# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-baselibs/emul-linux-x86-baselibs-2.5.5-r2.ebuild,v 1.1 2007/01/05 07:12:31 vapier Exp $

inherit eutils

DESCRIPTION="Base libraries for emulation of 32bit x86 on amd64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~dang/${P}.tar.bz2
	mirror://gentoo/${PF}-emul.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""
RESTRICT="nostrip"

RDEPEND="app-emulation/emul-linux-x86-compat"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv emul/linux/x86/lib lib32 || die
	mkdir usr
	mv emul/linux/x86/usr/lib usr/lib32 || die
	rmdir emul/linux/x86/usr emul/linux/x86 emul/linux emul || die
	mv lib32/pam_unix_*.so lib32/security/ || die
	rm usr/lib32/libnss_ldap.so.2 || die
	epatch ${PF}-emul.patch
}

src_install() {
	cp -a "${WORKDIR}"/* "${D}"/ || die
}
