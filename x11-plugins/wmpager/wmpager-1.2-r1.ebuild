# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpager/wmpager-1.2-r1.ebuild,v 1.12 2009/09/23 14:57:53 ssuominen Exp $

EAPI=2

DESCRIPTION="A simple pager docklet for the WindowMaker window manager."
HOMEPAGE="http://wmpager.sourceforge.net/"
SRC_URI="mirror://sourceforge/wmpager/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXext"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_prepare() {
	sed -i "s:\(WMPAGER_DEFAULT_INSTALL_DIR \).*:\1\"/usr/share/wmpager\":" \
		src/wmpager.c
}

src_install() {
	emake INSTALLDIR="${D}/usr" install || die
	rm -rf "${D}"/usr/man
	doman man/man1/*.1x
	dodoc README
}
