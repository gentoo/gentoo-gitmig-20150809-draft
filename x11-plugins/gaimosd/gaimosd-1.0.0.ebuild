# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaimosd/gaimosd-1.0.0.ebuild,v 1.2 2004/12/08 16:13:43 rizzo Exp $

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
	econf --enable-customized-buddies --enable-customized-conversations || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	#einstall || die

	dodoc README TODO
}
