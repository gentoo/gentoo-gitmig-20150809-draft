# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/autorun/autorun-3.15.ebuild,v 1.2 2006/09/05 07:11:02 vapier Exp $

inherit kde-functions eutils

DESCRIPTION="auto cdrom mounter for the lazy user"
HOMEPAGE="http://autorun.sourceforge.net/"
SRC_URI="mirror://sourceforge/autorun/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-text/xmlto
	=app-text/docbook-xml-dtd-4.1.2*"
RDEPEND=""

src_unpack() {
	unpack ${A}
	set-kdedir
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
