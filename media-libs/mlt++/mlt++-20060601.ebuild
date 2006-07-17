# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mlt++/mlt++-20060601.ebuild,v 1.1 2006/07/17 09:49:21 zypher Exp $

DESCRIPTION="Various bindings for mlt"
HOMEPAGE="http://mlt.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=media-libs/mlt-0.2.2"

src_compile() {
	econf
	emake
}

src_install() {
	make DESTDIR=${D} install

	dodoc README CUSTOMISING HOWTO
}
