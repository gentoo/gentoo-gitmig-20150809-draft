# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/zhcon/zhcon-0.2.3.ebuild,v 1.1 2004/03/14 11:27:41 usata Exp $

DESCRIPTION="A Fast CJK (Chinese/Japanese/Korean) Console Environment"
HOMEPAGE="http://zhcon.sourceforge.net/"
SRC_URI="mirror://sourceforge/zhcon/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/glibc"
#RDEPEND=""

src_unpack() {

	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff
	epatch ${FILESDIR}/${P}-assert-gentoo.diff
}

src_compile() {

	autoconf || die
	econf || die
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die
}
