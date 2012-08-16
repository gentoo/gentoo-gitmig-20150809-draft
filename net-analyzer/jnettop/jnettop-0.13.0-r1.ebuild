# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/jnettop/jnettop-0.13.0-r1.ebuild,v 1.5 2012/08/16 14:05:24 jer Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="A top like console network traffic visualiser"
HOMEPAGE="http://jnettop.kubs.info/"
SRC_URI="http://jnettop.kubs.info/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="net-libs/libpcap
	>=dev-libs/glib-2.0.1"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS README )

src_prepare() {
	epatch "${FILESDIR}/${P}-asneeded.patch"
	eautoreconf
}

src_install() {
	default
	newdoc .${PN} ${PN}.dotfile
}
