# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/detox/detox-1.2.0-r1.ebuild,v 1.2 2012/07/29 18:03:08 armin76 Exp $

EAPI=4

inherit eutils

MY_P="${PN}-${PV/_/-}"

DESCRIPTION="Safely remove spaces and strange characters from filenames"
HOMEPAGE="http://detox.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

S="${WORKDIR}"/${MY_P}

RDEPEND="dev-libs/popt"
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-parallel.patch \
		"${FILESDIR}"/${P}-LDFLAGS.patch
	sed \
		-e '/detoxrc.sample/d' \
		-i Makefile.in || die
}

src_configure() {
	econf --with-popt="${EPREFIX}/usr"
}
