# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pydf/pydf-0.9.6.ebuild,v 1.3 2003/08/05 18:07:16 vapier Exp $

DESCRIPTION="Enhanced df with colors"
HOMEPAGE="http://melkor.dnp.fmph.uniba.sk/~garabik/pydf"
SRC_URI="http://melkor.dnp.fmph.uniba.sk/~garabik/pydf/pydf_${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"

RDEPEND="dev-lang/python"

src_compile() { return 0; }

src_install() {
	dobin pydf
	dodoc COPYING INSTALL README
	doman pydf.1
	insinto /etc
	doins pydfrc
}

pkg_postinst() {
	ewarn "Please edit /etc/pydfrc to suit your needs"
}
