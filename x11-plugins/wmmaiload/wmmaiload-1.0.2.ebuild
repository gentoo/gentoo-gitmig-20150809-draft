# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmaiload/wmmaiload-1.0.2.ebuild,v 1.3 2005/04/07 17:11:06 blubb Exp $

DESCRIPTION="dockapp that monitors one or more mailboxes."
SRC_URI="http://tnemeth.free.fr/projets/programmes/${P}.tar.gz"
HOMEPAGE="http://tnemeth.free.fr/projets/dockapps.html"

SLOT="0"
KEYWORDS="x86 amd64 ~ppc ~sparc"
LICENSE="GPL-2"

DEPEND="virtual/x11
	>=x11-libs/gtk+-1.2.10-r11"
IUSE=""

src_compile() {
	econf || die "configure failed"
	emake || die "parallel make failed"
}

src_install () {
	einstall || die "make install failed"
}
