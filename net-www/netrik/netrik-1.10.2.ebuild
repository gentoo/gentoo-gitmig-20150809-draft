# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/netrik/netrik-1.10.2.ebuild,v 1.3 2003/09/06 02:05:10 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A text based web browser with no ssl support."
HOMEPAGE="http://netrik.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-1"

DEPENDS=">=sys-libs/ncurses-5.1
		 >=sys-libs/zlib-1.1.3
		 nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A} || die
}

src_compile() {
	local myconf
	econf \
		--prefix=/usr || die "Configure failed"
		emake || die "Compile problem"
}

src_install() {
	make prefix=${D}/usr datadir=${D}/usr/share mandir=${D}/usr/share/man libdir=${D} install \
	|| die "Unablr to do install"
}
