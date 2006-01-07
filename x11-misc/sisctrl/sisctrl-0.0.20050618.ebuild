# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/sisctrl/sisctrl-0.0.20050618.ebuild,v 1.3 2006/01/07 06:51:08 vapier Exp $

inherit eutils

DESCRIPTION="tool that allows you to tune SiS drivers from X"
HOMEPAGE="http://www.winischhofer.net/linuxsis630.shtml"
SRC_URI="http://www.winischhofer.net/sis/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/x11
	 >=dev-libs/glib-2.0
	 >=x11-libs/gtk+-2.0"
DEPEND="dev-util/pkgconfig
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-no-xv.patch
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
