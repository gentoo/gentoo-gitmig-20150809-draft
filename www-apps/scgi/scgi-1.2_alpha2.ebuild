# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/scgi/scgi-1.2_alpha2.ebuild,v 1.3 2004/11/17 04:14:21 robbat2 Exp $

inherit distutils

MY_P=${P/_alpha/a}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Replacement for the CGI protocol that is similar to FastCGI"
HOMEPAGE="http://www.mems-exchange.org/software/scgi/"
SRC_URI="http://www.mems-exchange.org/software/files/${PN}/${MY_P}.tar.gz"
LICENSE="CNRI"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

pkg_postinst() {
	distutils_pkg_postinst
	einfo "This package does not install mod_scgi"
	einfo "Please 'emerge mod_scgi' if you need it"
}
