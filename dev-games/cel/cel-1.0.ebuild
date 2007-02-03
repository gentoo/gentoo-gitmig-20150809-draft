# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/cel/cel-1.0.ebuild,v 1.1 2007/02/03 00:01:56 tupone Exp $

inherit eutils

MY_P=${PN}-src-${PV}

DESCRIPTION="A game entity layer based on Crystal Space"
HOMEPAGE="http://cel.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="python"

RDEPEND="dev-games/crystalspace
	dev-games/hawknl"

DEPEND="${RDEPEND}
	dev-util/jam"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf --disable-separate-debug-info \
		--disable-cstest \
		$(use_with python) \
		|| die "configure failed"
	jam || die "Jam failed"
}

src_install() {
	jam -q -s DESTDIR=${D} install || die "make install failed"

	# Fill cache directory for the examples
	cp ${D}/usr/share/${PN}/data/{basic_,}world
	cslight -video=null ${D}/usr/share/${PN}/data
	cp ${D}/usr/share/${PN}/data/{walktut_,}world
	cslight -video=null ${D}/usr/share/${PN}/data
	rm ${D}/usr/share/${PN}/data/world

	dodoc docs/history*.txt docs/todo.txt
}
