# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/scgi/scgi-1.2_alpha2.ebuild,v 1.2 2004/08/30 23:31:18 dholm Exp $

MY_P=${P/_alpha/a}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Replacement for the CGI protocol that is similar to FastCGI"
HOMEPAGE="http://www.mems-exchange.org/software/scgi/"
SRC_URI="http://www.mems-exchange.org/software/files/${PN}/${MY_P}.tar.gz"
LICENSE="CNRI"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

inherit distutils

pkg_postinst() {
	einfo "This package does not install mod_scgi"
	einfo "Please 'emerge mod_scgi' if you need it"
}
