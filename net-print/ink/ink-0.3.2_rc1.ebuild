# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/ink/ink-0.3.2_rc1.ebuild,v 1.1 2006/09/16 14:47:48 genstef Exp $

DESCRIPTION="A command line utility to display the ink level of your printer"
SRC_URI="mirror://sourceforge/ink/${P/_}.tar.gz"
HOMEPAGE="http://ink.sourceforge.net/"

SLOT="0"
KEYWORDS="~x86 ~amd64"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=net-print/libinklevel-0.6.6_rc3"

S=${WORKDIR}/${PN}

src_install () {
	emake DESTDIR=${D}/usr install || die "emake install failed"
	dodoc README
}
