# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/liblzw/liblzw-0.1.ebuild,v 1.1 2005/11/26 11:15:23 vapier Exp $

DESCRIPTION="small C library for reading LZW compressed files (.Z)"
HOMEPAGE="http://freestdf.sourceforge.net/liblzw.php"
SRC_URI="mirror://sourceforge/freestdf/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
