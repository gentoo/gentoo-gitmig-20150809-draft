# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdiskmon/wmdiskmon-0.0.1.ebuild,v 1.10 2007/07/22 05:13:35 dberkholz Exp $

IUSE=""

DESCRIPTION="Window Maker dockapp to display disk space usage."
SRC_URI="http://tnemeth.free.fr/projets/programmes/${P}.tar.gz"
HOMEPAGE="http://tnemeth.free.fr/projets/dockapps.html"

SLOT="0"
KEYWORDS="x86 ppc ~sparc"
LICENSE="GPL-2"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXt
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

src_install () {
	einstall || die "Installation failed"

	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
