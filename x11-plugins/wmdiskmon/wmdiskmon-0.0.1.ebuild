# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdiskmon/wmdiskmon-0.0.1.ebuild,v 1.5 2004/09/02 18:22:40 pvdabeel Exp $

inherit eutils

IUSE=""

DESCRIPTION="Window Maker dockapp to display disk space usage."
SRC_URI="http://tnemeth.free.fr/projets/programmes/${P}.tar.gz"
HOMEPAGE="http://tnemeth.free.fr/projets/dockapps.html"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"

DEPEND="virtual/x11"

src_install () {
	einstall || die "Installation failed"

	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO
}
