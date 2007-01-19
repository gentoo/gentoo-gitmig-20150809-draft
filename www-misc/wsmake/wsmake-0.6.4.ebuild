# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/wsmake/wsmake-0.6.4.ebuild,v 1.4 2007/01/19 21:02:01 armin76 Exp $

inherit eutils

DESCRIPTION="Website Pre-processor"
HOMEPAGE="http://www.wsmake.org/"
SRC_URI="http://ftp.wsmake.org/pub/wsmake6/stable/wsmake-0.6.4.tar.bz2"

KEYWORDS="x86"
LICENSE="GPL-2 Artistic"
SLOT="0"
IUSE=""

src_unpack () {
	unpack ${A} && cd "${S}"
	#Apply patch to allow compiling
	epatch "${FILESDIR}/${P}-bv.diff" || die "epatch failed."
}

src_compile () {
	econf || die "econf failed"
	emake || die "emake failed"
	cd doc
	tar -cf examples.tar examples || die
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS COPYING ChangeLog* DEVELOPERS LICENSE NEWS README TODO
	cd doc
	dodoc manual.txt examples.tar
}

