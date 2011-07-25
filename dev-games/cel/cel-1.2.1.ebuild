# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/cel/cel-1.2.1.ebuild,v 1.5 2011/07/25 17:02:32 mr_bones_ Exp $

EAPI=2
inherit eutils

MY_P=${PN}-src-${PV}
DESCRIPTION="A game entity layer based on Crystal Space"
HOMEPAGE="http://cel.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python"

RDEPEND="~dev-games/crystalspace-${PV}
	dev-games/hawknl"
DEPEND="${RDEPEND}
	dev-util/ftjam"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-glibc210.patch
}

src_configure() {
	econf \
		--disable-separate-debug-info \
		--disable-cstest \
		$(use_with python) \
		|| die
}

src_compile() {
	jam -q || die "jam failed"
}

src_install() {
	jam -q -s DESTDIR="${D}" install || die "jam install failed"

	# Fill cache directory for the examples
	cp "${D}"/usr/share/${PN}/data/{basic_,}world
	cslight -video=null "${D}"/usr/share/${PN}/data
	cp "${D}"/usr/share/${PN}/data/{walktut_,}world
	cslight -video=null "${D}"/usr/share/${PN}/data
	rm "${D}"/usr/share/${PN}/data/world

	dodoc docs/history*.txt docs/todo.txt
}
