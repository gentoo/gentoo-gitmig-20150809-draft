# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtomfloat/libtomfloat-0.02.ebuild,v 1.2 2005/03/17 00:42:56 vapier Exp $

DESCRIPTION="library for floating point number manipulation"
HOMEPAGE="http://float.libtomcrypt.org/"
SRC_URI="http://float.libtomcrypt.org/files/ltf-${PV}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_install() {
	make install DESTDIR="${D}" || die
	dodoc changes.txt *.pdf
	docinto demo ; dodoc demo/*
}
