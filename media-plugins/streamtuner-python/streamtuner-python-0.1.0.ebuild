# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/streamtuner-python/streamtuner-python-0.1.0.ebuild,v 1.5 2005/09/04 10:25:48 flameeyes Exp $

DESCRIPTION="A plugin for Streamtuner that provides an embedded Python interpreter."
SRC_URI="http://savannah.nongnu.org/download/streamtuner/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/streamtuner/"

IUSE=""
SLOT="0"
KEYWORDS="x86 ~ppc"
LICENSE="BSD"

DEPEND=">=net-misc/streamtuner-0.12.0
	>=dev-lang/python-2.0"

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
