# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/detox/detox-1.1.1-r1.ebuild,v 1.7 2006/09/03 19:53:39 blubb Exp $

inherit eutils

DESCRIPTION="detox safely removes spaces and strange characters from filenames"
HOMEPAGE="http://detox.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~hppa mips ~ppc sparc x86"
IUSE=""

DEPEND="dev-libs/popt
	sys-devel/flex
	sys-devel/bison"

RDEPEND="dev-libs/popt"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-use-correct-type.diff
}

src_compile() {
	econf --with-popt || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	rm -f "${D}/etc/detoxrc.sample"
	dodoc README CHANGES
}

