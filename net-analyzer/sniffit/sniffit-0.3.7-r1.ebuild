# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sniffit/sniffit-0.3.7-r1.ebuild,v 1.4 2004/07/09 20:25:04 eldad Exp $

inherit eutils

MY_P="${P/-/.}.beta"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Interactive Packet Sniffer"
SRC_URI="http://reptile.rug.ac.be/~coder/sniffit/files/${MY_P}.tar.gz
	 http://www.clan-tva.com/m0rpheus/sniffit_0.3.7.beta-10.diff"
HOMEPAGE="http://reptile.rug.ac.be/~coder/sniffit/sniffit.html"

DEPEND=">=net-libs/libpcap-0.6.2
	>=sys-libs/ncurses-5.2"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc"
IUSE=""

src_unpack() {
	unpack ${MY_P}.tar.gz

	cd ${S}
	epatch ${DISTDIR}/sniffit_0.3.7.beta-10.diff

	# Fix issues with gcc-3.3 (bug #25328)
	epatch ${FILESDIR}/${P}-gcc33.patch
}

src_compile() {
	econf || die

	emake OBJ_FLAG="-w -c ${CFLAGS}" \
	      EXE_FLAG="-w ${CFLAGS} -o sniffit" || die
}

src_install () {
	dobin sniffit

	doman sniffit.5 sniffit.8
	dodoc README* PLUGIN-HOWTO BETA* HISTORY LICENSE changelog
}

