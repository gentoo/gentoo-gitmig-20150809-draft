# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/autorun/autorun-3.10.ebuild,v 1.2 2004/10/14 06:31:50 mr_bones_ Exp $

inherit kde-functions eutils

DESCRIPTION="auto cdrom mounter for the lazy user"
HOMEPAGE="http://autorun.sourceforge.net/"
SRC_URI="mirror://sourceforge/autorun/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-text/xmlto"
RDEPEND=""

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo.patch
	set-kdedir
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
