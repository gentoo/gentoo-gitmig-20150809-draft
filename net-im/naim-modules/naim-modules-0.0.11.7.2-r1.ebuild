# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/naim-modules/naim-modules-0.0.11.7.2-r1.ebuild,v 1.2 2009/09/23 08:30:16 ssuominen Exp $

EAPI=2
MY_PV=${PV}-2004-07-20-0047

DESCRIPTION="a bunch of modules for the naim im client"
HOMEPAGE="http://site.n.ml.org/info/naim/"
SRC_URI="http://site.n.ml.org/download/20050313142544/naim/${PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=net-im/naim-0.11.7.3"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-${MY_PV}

src_configure() {
	econf \
		--with-pkgdocdir=/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
