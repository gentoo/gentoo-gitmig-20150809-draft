# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/poweriso/poweriso-1.3.ebuild,v 1.1 2008/11/29 11:01:58 ssuominen Exp $

DESCRIPTION="Utility to extract, list and convert PowerISO DAA image files"
HOMEPAGE="http://www.poweriso.com"
SRC_URI="http://www.${PN}.com/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}

RESTRICT="strip"

src_install() {
	into /opt
	dobin ${PN}
}
