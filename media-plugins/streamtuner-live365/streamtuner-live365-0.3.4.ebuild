# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/streamtuner-live365/streamtuner-live365-0.3.4.ebuild,v 1.6 2004/09/22 17:57:25 eradicator Exp $

DESCRIPTION="A plugin for Streamtuner that provides support for live365 streams."
SRC_URI="http://savannah.nongnu.org/download/streamtuner/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/streamtuner/"

IUSE=""
SLOT="0"
KEYWORDS="x86 ~ppc amd64"
LICENSE="BSD"

DEPEND=">=net-misc/streamtuner-0.12.0"

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README INSTALL
}
