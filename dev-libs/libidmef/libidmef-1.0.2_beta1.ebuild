# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libidmef/libidmef-1.0.2_beta1.ebuild,v 1.1 2006/02/08 00:35:43 halcy0n Exp $

MY_PV=${PV/_/-}
DESCRIPTION="Implementation of the IDMEF XML draft"
HOMEPAGE="http://sourceforge.net/projects/libidmef/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.5.6"

S="${WORKDIR}"/${PN}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc API AUTHORS ChangeLog FAQ NEWS README TODO
}
