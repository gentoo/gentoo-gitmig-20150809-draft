# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-windows/cups-windows-6.0.ebuild,v 1.3 2008/10/10 09:57:27 flameeyes Exp $

DESCRIPTION="CUPS PostScript Driver for Windows"
HOMEPAGE="http://cups.org/windows/"
SRC_URI="http://ftp.easysw.com/pub/cups/windows/${P}-source.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=net-print/cups-1.2"
DEPEND="${RDEPEND}"

src_install() {
	emake install BUILDROOT="${D}" || die
	dodoc README.txt
}
