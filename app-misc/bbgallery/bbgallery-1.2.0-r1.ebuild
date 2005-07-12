# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bbgallery/bbgallery-1.2.0-r1.ebuild,v 1.1 2005/07/12 02:12:00 smithj Exp $

DESCRIPTION="Webpage image gallery creation perl script"
HOMEPAGE="http://bbgallery.sourceforge.net/"
SRC_URI="mirror://sourceforge/bbgallery/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="gimp"

RDEPEND="media-gfx/gimp
	 dev-lang/perl
	 media-gfx/imagemagick
	 dev-perl/URI
	 dev-perl/libwww-perl
	 dev-perl/HTML-Template
	 dev-perl/HTML-Parser
	 gimp? ( dev-perl/gimp-perl )"

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
	dohtml doc/*.html
}
