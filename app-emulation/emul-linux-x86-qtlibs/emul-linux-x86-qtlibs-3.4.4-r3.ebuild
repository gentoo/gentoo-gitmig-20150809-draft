# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-qtlibs/emul-linux-x86-qtlibs-3.4.4-r3.ebuild,v 1.1 2007/01/05 07:13:25 vapier Exp $

inherit eutils

DESCRIPTION="QT 2/3 libraries for emulation of 32bit x86 on amd64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="immqt-bc? ( mirror://gentoo/emul-linux-x86-qtlibs-immqt-${PV}.tar.bz2 )
	!immqt-bc? ( mirror://gentoo/emul-linux-x86-qtlibs-noime-${PV}.tar.bz2 )
	mirror://gentoo/emul-linux-x86-qtlibs-extras-${PV}.tar.bz2
	mirror://gentoo/${PF}-emul.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="immqt-bc"
RESTRICT="nostrip"

RDEPEND="virtual/libc
	>=app-emulation/emul-linux-x86-baselibs-2.5.5-r2
	>=app-emulation/emul-linux-x86-xlibs-7.0-r7"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"
	mkdir -p usr/qt/3
	mv emul/linux/x86/usr/lib usr/lib32 || die
	mv emul/linux/x86/usr/qt/3/lib usr/qt/3/lib32 || die
	mv emul/linux/x86/usr/qt/3/plugins usr/qt/3/ || die
	rmdir emul/linux/x86/usr/qt/3 emul/linux/x86/usr/qt emul/linux/x86/usr emul/linux/x86 emul/linux emul || die
	epatch ${PF}-emul.patch
}

src_install() {
	cp -a "${WORKDIR}"/* "${D}"/ || die
}
