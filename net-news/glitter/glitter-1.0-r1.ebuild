# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/glitter/glitter-1.0-r1.ebuild,v 1.7 2004/07/14 20:57:35 swegener Exp $

inherit eutils

DESCRIPTION="Glitter - a binary downloader for newsgroups"
HOMEPAGE="http://www.mews.org.uk/glitter/"
SRC_URI="http://www.mews.org.uk/glitter/${P}.tar.gz
	http://gentoo.mirror.at.stealer.net/files/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE=""
DEPEND="dev-lang/perl
	gnome-base/gnome-libs"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gary-perl58.patch
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
}
