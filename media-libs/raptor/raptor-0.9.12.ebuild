# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/raptor/raptor-0.9.12.ebuild,v 1.4 2004/02/13 03:04:30 eradicator Exp $

DESCRIPTION="The RDF Parser Toolkit"
HOMEPAGE="http://www.redland.opensource.ac.uk/raptor/"
SRC_URI="http://www.redland.opensource.ac.uk/dist/source/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE="curl"
DEPEND="virtual/glibc
	ssl? ( dev-libs/openssl )
	curl? ( net-ftp/curl )
	>=dev-libs/libxml2-2.4.24"

S=${WORKDIR}/${P}

DOC="AUTHORS COPYING COPYING.LIB ChangeLog INSTALL LICENSE.txt NEWS README"
HTML="INSTALL.html LICENSE.html MPL.html NEWS.html README.html"

src_install() {
	make DESTDIR=${D} install || die

	dodoc ${DOC}
	dohtml ${HTML}
}
