# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/ink/ink-0.4.1.ebuild,v 1.1 2007/06/19 07:34:24 genstef Exp $

DESCRIPTION="A command line utility to display the ink level of your printer"
SRC_URI="mirror://sourceforge/ink/${P/_}.tar.gz"
HOMEPAGE="http://ink.sourceforge.net/"

SLOT="0"
KEYWORDS="~x86 ~amd64"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=net-print/libinklevel-0.7.1"
RDEPEND="${DEPEND}"

src_install () {
	emake DESTDIR=${D}/usr install || die "emake install failed"
	dodoc README
}
