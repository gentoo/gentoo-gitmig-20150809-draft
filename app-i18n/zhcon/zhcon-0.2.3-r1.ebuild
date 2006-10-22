# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/zhcon/zhcon-0.2.3-r1.ebuild,v 1.3 2006/10/22 22:40:27 tsunam Exp $

inherit eutils

DESCRIPTION="A Fast CJK (Chinese/Japanese/Korean) Console Environment"
HOMEPAGE="http://zhcon.sourceforge.net/"
SRC_URI="mirror://sourceforge/zhcon/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc
	sys-devel/autoconf"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
	epatch ${FILESDIR}/${P}-assert-gentoo.diff
	epatch ${FILESDIR}/${P}-gcc34.patch

	# bug #78117 - unauthorized file acess CAN-2005-0072
	epatch ${FILESDIR}/${P}-CAN-2005-0072.patch
}

src_compile() {
	autoconf || die "autoconf failed"
	econf || die
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
