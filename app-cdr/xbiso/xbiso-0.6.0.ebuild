# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/xbiso/xbiso-0.6.0.ebuild,v 1.1 2004/05/27 03:38:20 vapier Exp $


DESCRIPTION="Xbox xdvdfs ISO extraction utility"
HOMEPAGE="http://sourceforge.net/projects/xbiso/"
SRC_URI="mirror://sourceforge/xbiso/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_install() {
	dobin xbiso || die "install failed"
	dodoc README CHANGELOG
}
