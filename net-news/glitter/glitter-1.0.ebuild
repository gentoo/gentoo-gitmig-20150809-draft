# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/glitter/glitter-1.0.ebuild,v 1.8 2004/03/20 07:32:10 mr_bones_ Exp $

DESCRIPTION="Glitter - a binary downloader for newsgroups"
HOMEPAGE="http://www.mews.org.uk/glitter/"
SRC_URI="http://www.mews.org.uk/glitter/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE=""
DEPEND="gnome-base/gnome-libs"

src_unpack() {
	unpack ${A}
	echo "Patching gary for use with perl 5.8"
	cd ${S}; patch < ${FILESDIR}/${P}-gary-perl58.patch
}

src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--sysconfdir=/etc || die "./configure failed"

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
