# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmaiload/wmmaiload-1.0.2.ebuild,v 1.6 2008/01/12 01:04:26 coldwind Exp $

DESCRIPTION="dockapp that monitors one or more mailboxes"
SRC_URI="http://tnemeth.free.fr/projets/programmes/${P}.tar.gz"
HOMEPAGE="http://tnemeth.free.fr/projets/dockapps.html"

SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
LICENSE="GPL-2"
IUSE=""

DEPEND="=x11-libs/gtk+-1*
	x11-libs/libXpm"
RDEPEND="${DEPEND}"

src_install () {
	einstall || die "make install failed"
	dodoc AUTHORS ChangeLog FAQ THANKS
}
