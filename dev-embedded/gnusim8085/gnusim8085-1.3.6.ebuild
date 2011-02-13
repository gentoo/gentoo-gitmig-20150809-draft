# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gnusim8085/gnusim8085-1.3.6.ebuild,v 1.1 2011/02/13 22:10:33 radhermit Exp $

EAPI=4

inherit eutils autotools

DESCRIPTION="A GTK2 8085 Simulator"
HOMEPAGE="http://gnusim8085.org"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls examples"

DEPEND=">=x11-libs/gtk+-2.12
	x11-libs/gtksourceview:2.0
	nls? ( >=sys-devel/gettext-0.10.40 )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable nls)
}

src_install() {
	default_src_install

	doman doc/gnusim8085.1

	if use examples ; then
		docompress -x /usr/share/doc/${PF}/examples
		insinto /usr/share/doc/${PF}/examples
		doins doc/examples/*.asm doc/asm-guide.txt
	fi
}
