# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/detox/detox-1.2.0.ebuild,v 1.6 2011/01/04 17:53:51 jlec Exp $

inherit eutils

MY_P="${PN}-${PV/_/-}"

DESCRIPTION="Safely remove spaces and strange characters from filenames"
HOMEPAGE="http://detox.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~hppa ~mips ppc sparc x86"
IUSE=""

S="${WORKDIR}"/${MY_P}

RDEPEND="dev-libs/popt"
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch \
		"${FILESDIR}"/${P}-parallel.patch \
		"${FILESDIR}"/${P}-LDFLAGS.patch
}

src_compile() {
	econf --with-popt
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	rm -f "${D}/etc/detoxrc.sample"
	dodoc README CHANGES || die
}
