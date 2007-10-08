# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libroadnav/libroadnav-0.18.ebuild,v 1.1 2007/10/08 06:14:08 dirtyepic Exp $

inherit wxwidgets

DESCRIPTION="LibRoadnav is a library capable of plotting street maps and providing driving directions for US addresses"
HOMEPAGE="http://roadnav.sourceforge.net"
SRC_URI="mirror://sourceforge/roadnav/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="=x11-libs/wxGTK-2.6*"

src_compile() {
	WX_GTK_VER=2.6
	need-wxwidgets gtk2

	econf \
		--with-wx-config=${WX_CONFIG} \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	# generic or empty
	for f in NEWS COPYING INSTALL; do
		rm -f "${D}"/usr/share/doc/${PN}/${f}
	done

	# --docdir is broken and hardcoded to ${PN}
	mv "${D}"/usr/share/doc/${PN} "${D}"/usr/share/doc/${P}
}
