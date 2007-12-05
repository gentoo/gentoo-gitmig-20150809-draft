# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/vbetool/vbetool-1.0.ebuild,v 1.1 2007/12/05 00:05:36 robbat2 Exp $

inherit eutils flag-o-matic autotools

DESCRIPTION="Run real-mode video BIOS code to alter hardware state (i.e. reinitialize video card)"
HOMEPAGE="http://www.srcf.ucam.org/~mjg59/vbetool/"
#SRC_URI="${HOMEPAGE}${PN}_${PV}.orig.tar.gz"
#SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${P//-/_}-1.tar.gz"
#SRC_URI="http://www.srcf.ucam.org/~mjg59/${PN}/${P//-/_}-1.tar.gz"
SRC_URI="http://archive.ubuntu.com/ubuntu/pool/main/${PN:0:1}/${PN}/${P//-/_}-0ubuntu1.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="sys-libs/zlib
		sys-apps/pciutils
		dev-libs/libx86"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	#epatch ${FILESDIR}/${P}-pci-compile-fix.patch
	sed -i \
		-e '/vbetool_LDADD/s,$(libdir)/libpci.a,-lpci,' \
		"${S}/Makefile.am"
	cd "${S}"
	eautoreconf
}

src_compile() {
	econf --with-x86emu  || die "could not configure"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc LRMI
}
