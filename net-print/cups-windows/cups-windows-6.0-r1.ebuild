# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-windows/cups-windows-6.0-r1.ebuild,v 1.1 2011/10/02 21:39:17 dilfridge Exp $

EAPI=4

DESCRIPTION="CUPS PostScript Driver for Windows"
HOMEPAGE="http://cups.org/windows/"
SRC_URI="http://ftp.easysw.com/pub/cups/windows/${P}-source.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=net-print/cups-1.2"
DEPEND="${RDEPEND}"

src_install() {
	emake install BUILDROOT="${D}"
	dodoc README.txt
	einfo "Copying missing cups6.ppd file"
	cp "${S}/i386/cups6.ppd" "${ED}/usr/share/cups/drivers/"
}
