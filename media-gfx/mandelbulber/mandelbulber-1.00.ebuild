# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/mandelbulber/mandelbulber-1.00.ebuild,v 1.1 2011/04/27 20:19:08 xarthisius Exp $

EAPI=3

inherit eutils toolchain-funcs

MY_P=${PN}${PV}

DESCRIPTION="Tool to render 3D fractals"
HOMEPAGE="http://sites.google.com/site/mandelbulber/home"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	>=media-libs/libsndfile-1
	>=media-libs/libpng-1.4
	virtual/jpeg"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-qa.patch \
		"${FILESDIR}"/${P}-gcc46.patch
}

src_compile() {
	emake CXX="$(tc-getCXX)" -C makefiles all || die
}

src_install() {
	dobin makefiles/${PN} || die
	dodoc README NEWS || die
	insinto /usr/share/${PN}
	doins -r .${PN}/* || die
}

pkg_postinst() {
	elog "Before you run ${PN} please copy /usr/share/${PN}/* to \${HOME}/.${PN}"
}
