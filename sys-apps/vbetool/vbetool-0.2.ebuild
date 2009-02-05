# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/vbetool/vbetool-0.2.ebuild,v 1.2 2009/02/05 05:43:04 darkside Exp $

DESCRIPTION="Run real-mode video BIOS code to alter hardware state (i.e. reinitialize video card)"
HOMEPAGE="http://www.codon.org.uk/~mjg59/vbetool/"
SRC_URI="${HOMEPAGE}${PN}_${PV}.orig.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="sys-apps/pciutils"

src_compile() {
	LIBS="-lpci" econf || die "could not configure"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc LRMI
}
