# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-i18n/manpages-ru/manpages-ru-0.7.ebuild,v 1.7 2003/02/13 08:47:08 vapier Exp $

DESCRIPTION="A collection of Russian translations of Linux manual pages."
HOMEPAGE="http://alexm.here.ru/manpages-ru/"
LICENSE="GPL-2"

DEPEND=""
RDEPEND="sys-apps/man"

KEYWORDS="x86 ppc"
SLOT="0"

SRC_URI="ftp://ftp.win.tue.nl/pub/linux-local/manpages/translations/man-pages-ru-${PV}.tar.gz"
S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff || die
}

src_compile() {
	make || die
}
		
src_install() {
	make INSTALLPATH=${D}/usr/share/man LANG_SUBDIR=ru install || die
	prepallman
}
