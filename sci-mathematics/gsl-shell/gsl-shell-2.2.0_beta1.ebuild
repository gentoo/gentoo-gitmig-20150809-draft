# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/gsl-shell/gsl-shell-2.2.0_beta1.ebuild,v 1.1 2012/09/20 16:09:24 grozin Exp $

EAPI=4
inherit eutils versionator

DESCRIPTION="Lua interactive shell for sci-libs/gsl"
HOMEPAGE="http://www.nongnu.org/gsl-shell/"
MY_P=$(version_format_string '${PN}-$1.$2.$3-$4')
SRC_URI="http://download.savannah.gnu.org/releases/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE="fox"

DEPEND=">=sci-libs/gsl-1.14
	>=x11-libs/agg-2.5
	>=media-libs/freetype-2.4.10
	sys-libs/readline
	|| ( media-fonts/ubuntu-font-family media-fonts/freefont-ttf media-fonts/dejavu )
	fox? ( x11-libs/fox:1.6 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}/${PN}.patch"
}

src_compile() {
	emake -j1 CFLAGS="${CFLAGS}"
}
