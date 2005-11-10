# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdiskmon/wmdiskmon-0.0.1.ebuild,v 1.8 2005/11/10 08:56:26 s4t4n Exp $

IUSE=""

DESCRIPTION="Window Maker dockapp to display disk space usage."
SRC_URI="http://tnemeth.free.fr/projets/programmes/${P}.tar.gz"
HOMEPAGE="http://tnemeth.free.fr/projets/dockapps.html"

SLOT="0"
KEYWORDS="x86 ppc ~sparc"
LICENSE="GPL-2"

DEPEND="virtual/x11"

src_install () {
	einstall || die "Installation failed"

	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
