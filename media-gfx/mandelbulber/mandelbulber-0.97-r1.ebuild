# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/mandelbulber/mandelbulber-0.97-r1.ebuild,v 1.1 2011/01/30 12:30:07 xarthisius Exp $

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
	epatch "${FILESDIR}"/${P}-qa.patch
}

src_compile() {
	emake CXX="$(tc-getCXX)" -C src/Release all || die
}

src_install() {
	dobin src/Release/${PN} || die
	dodoc README.txt CHANGE_LOG.txt || die
	insinto /usr/share/${PN}
	doins -r .${PN}/* || die
}

pkg_postinst() {
	elog "Before you run ${PN} please copy /usr/share/${PN}/* to \${HOME}/.${PN}"
}
