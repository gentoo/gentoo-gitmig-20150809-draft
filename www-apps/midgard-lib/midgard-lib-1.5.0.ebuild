# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/midgard-lib/midgard-lib-1.5.0.ebuild,v 1.1 2004/09/22 10:43:26 rl03 Exp $

IUSE=""
SLOT="0"

DESCRIPTION="Midgard libraries"
HOMEPAGE="http://www.midgard-project.org/"
SRC_URI="http://www.midgard-project.org/midcom-serveattachmentguid-7b8c6945dca540150511d07763be2c13/${P}.tar.bz2"

KEYWORDS="~x86"

DEPEND="
	dev-libs/expat
	dev-db/mysql
	dev-libs/glib"

LICENSE="LGPL-2"

src_install() {
	dodoc AUTHORS ChangeLog INSTALL NEWS README
	einstall || die "install failed"
}
