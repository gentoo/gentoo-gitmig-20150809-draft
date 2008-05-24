# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fracplanet/fracplanet-0.3.3.ebuild,v 1.1 2008/05/24 12:48:20 drac Exp $

EAPI=1

inherit qt3

DESCRIPTION="Interactive tool for creating fractal planets with terrains, oceans, rivers, lakes and icecaps."
HOMEPAGE="http://www.bottlenose.demon.co.uk/share/fracplanet"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="x11-libs/qt:3
	dev-libs/boost
	virtual/opengl
	virtual/glu"
# We use xsltproc only at build-time.
DEPEND="${RDEPEND}
	dev-libs/libxslt"

S=${WORKDIR}/${PN}

src_compile() {
	export PATH="${QTDIR}/bin:${PATH}"
	./configure || die "./configure failed."
	emake || die "emake failed."
}

src_install() {
	dobin ${PN} || die "dobin failed."
	doman man/man1/*.1
	dodoc BUGS CHANGES README THANKS TODO
	dohtml *.{css,htm}
}
