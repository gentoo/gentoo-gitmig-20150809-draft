# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bbgallery/bbgallery-1.1.0.ebuild,v 1.8 2004/02/17 08:38:26 mr_bones_ Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Webpage image gallery creation perl script"
HOMEPAGE="http://bbgallery.sourceforge.net/"
SRC_URI="mirror://sourceforge/bbgallery/${PN}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

RDEPEND="media-gfx/gimp
	 dev-lang/perl
	 media-gfx/imagemagick
	 dev-perl/URI
	 dev-perl/libwww-perl
	 dev-perl/HTML-Parser"

DEPEND="sys-apps/sed"

src_compile(){
	emake || die "compile failed"
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
