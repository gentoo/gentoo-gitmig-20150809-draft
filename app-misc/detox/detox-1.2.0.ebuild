# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/detox/detox-1.2.0.ebuild,v 1.5 2008/12/31 16:29:07 armin76 Exp $

inherit eutils

MY_P="${PN}-${PV/_/-}"

DESCRIPTION="detox safely removes spaces and strange characters from filenames"
HOMEPAGE="http://detox.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~hppa ~mips ppc sparc x86"
IUSE=""

S=${WORKDIR}/${MY_P}

RDEPEND="dev-libs/popt"
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-parallel.patch
	epatch "${FILESDIR}"/${P}-LDFLAGS.patch
}

src_compile() {
	econf --with-popt
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	rm -f "${D}/etc/detoxrc.sample"
	dodoc README CHANGES
}
