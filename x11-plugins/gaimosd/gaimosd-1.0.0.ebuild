# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaimosd/gaimosd-1.0.0.ebuild,v 1.1 2004/09/20 15:52:10 rizzo Exp $

inherit eutils

DESCRIPTION="Gaim OSD is an implementation of the XOSD library, allowing Gaim to display several notification messages."
HOMEPAGE="http://gaimosd.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=net-im/gaim-1.0.0
		x11-libs/xosd"
#RDEPEND=""

#S=${WORKDIR}/${P}

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	#einstall || die

	dodoc README TODO
}
