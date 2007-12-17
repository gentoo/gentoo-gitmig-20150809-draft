# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/detox/detox-1.2.0_rc3.ebuild,v 1.1 2007/12/17 18:09:33 armin76 Exp $

inherit eutils

MY_P="${PN}-${PV/_/-}"

DESCRIPTION="detox safely removes spaces and strange characters from filenames"
HOMEPAGE="http://detox.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

DEPEND="dev-libs/popt
	sys-devel/flex
	sys-devel/bison"

RDEPEND="dev-libs/popt"

src_unpack() {
	unpack ${A}
	cd "${S}"

#	epatch "${FILESDIR}"/${P}-use-correct-type.diff
#	epatch "${FILESDIR}"/${PV}-install-permissions-fix.patch
}

src_compile() {
	econf --with-popt || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	rm -f "${D}/etc/detoxrc.sample"
	dodoc README CHANGES
}
