# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pydf/pydf-0.9.6.ebuild,v 1.11 2005/11/09 05:15:20 weeve Exp $

DESCRIPTION="Enhanced df with colors"
HOMEPAGE="http://melkor.dnp.fmph.uniba.sk/~garabik/pydf"
SRC_URI="http://melkor.dnp.fmph.uniba.sk/~garabik/pydf/pydf_${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND="dev-lang/python"

src_compile() { return 0; }

src_install() {
	dobin pydf || die
	dodoc INSTALL README
	doman pydf.1
	insinto /etc
	doins pydfrc
}

pkg_postinst() {
	ewarn "Please edit /etc/pydfrc to suit your needs"
}
