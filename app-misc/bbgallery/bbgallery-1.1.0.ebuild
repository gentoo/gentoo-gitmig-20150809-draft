# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bbgallery/bbgallery-1.1.0.ebuild,v 1.9 2004/04/10 09:20:30 mr_bones_ Exp $

DESCRIPTION="Webpage image gallery creation perl script"
HOMEPAGE="http://bbgallery.sourceforge.net/"
SRC_URI="mirror://sourceforge/bbgallery/${PN}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="media-gfx/gimp
	 dev-lang/perl
	 media-gfx/imagemagick
	 dev-perl/URI
	 dev-perl/libwww-perl
	 dev-perl/HTML-Parser"

DEPEND="sys-apps/sed"

src_compile() {
	emake || die "compile failed"
}

src_install() {
	dobin bbgallery || die "dobin failed"
	newbin Contrib/JPG2jpg.pl JPG2jpg || die "newbin failed"

	exeinto /usr/lib/bbgallery
	doexe gimp_scale.pl || die "doexe failed"

	dodoc CHANGELOG CREDITS README
}
