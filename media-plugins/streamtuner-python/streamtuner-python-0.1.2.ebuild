# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/streamtuner-python/streamtuner-python-0.1.2.ebuild,v 1.5 2004/09/22 17:58:58 eradicator Exp $

inherit eutils

DESCRIPTION="A plugin for Streamtuner that provides an embedded Python interpreter."
SRC_URI="http://savannah.nongnu.org/download/streamtuner/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/streamtuner/"

IUSE=""
SLOT="0"
KEYWORDS="x86 ~ppc amd64 sparc"
LICENSE="BSD"

DEPEND=">=net-misc/streamtuner-0.12.0
	>=dev-lang/python-2.3"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-configure.patch
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README INSTALL
}
