# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/streamtuner-live365/streamtuner-live365-0.3.0.ebuild,v 1.8 2005/09/03 23:42:43 flameeyes Exp $

IUSE=""

DESCRIPTION="A plugin for Streamtuner. It allow to play live365 streams"
SRC_URI="http://savannah.nongnu.org/download/streamtuner/streamtuner-live365.pkg/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/streamtuner/"
KEYWORDS="x86"
SLOT="0"
LICENSE="as-is"

DEPEND=">=net-misc/streamtuner-0.9.0"

src_install () {
	make DESTDIR=${D} \
		sysconfdir=${D}/etc \
		install || die
	dodoc ChangeLog NEWS README
}
