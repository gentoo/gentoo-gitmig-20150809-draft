# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/pydf/pydf-0.9.6.ebuild,v 1.1 2003/05/04 01:32:19 avenj Exp $

S="${WORKDIR}/${P}"

DESCRIPTION="Enhanced df with colors."

SRC_URI="http://melkor.dnp.fmph.uniba.sk/~garabik/pydf/pydf_${PV}.tar.gz"
HOMEPAGE="http://melkor.dnp.fmph.uniba.sk/~garabik/pydf"
LICENSE="as-is"
DEPEND="dev-lang/python"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""


src_compile() {
	echo "Nothing to compile for ${P}."
}

src_install () {

	dobin pydf

	dodoc COPYING INSTALL README

	doman pydf.1

	insinto /etc
	doins pydfrc
}

pkg_postinst() {
	ewarn "Please edit /etc/pydfrc to suit your needs."
}
