# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/bbgallery/bbgallery-1.1.0.ebuild,v 1.3 2002/09/09 21:49:01 mcummings Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Webpage image gallery creation perl script"
HOMEPAGE="http://www.bb-zone.com/zope/bbzone/projects/bbgallery"
SRC_URI="ftp://ftp.bb-zone.com/pub/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

RDEPEND="media-gfx/gimp
	 sys-devel/perl
	 media-gfx/imagemagick
	 dev-perl/URI
	 dev-perl/libwww-perl
	 dev-perl/HTML-Parser"

DEPEND="sys-apps/sed"

src_compile(){
	emake || die
}

src_install(){
	dobin bbgallery

	mv Contrib/JPG2jpg.pl Contrib/JPG2jpg
	dobin Contrib/JPG2jpg

	dodir /usr/lib/bbgallery
	exeinto /usr/lib/bbgallery
	doexe gimp_scale.pl

	dodoc CHANGELOG COPYING CREDITS README
}
