# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/galleryadd/galleryadd-2.30.ebuild,v 1.2 2008/11/20 02:10:10 robbat2 Exp $

DESCRIPTION="Perl script to recursively adds directories/images to Gallery"
HOMEPAGE="http://iainlea.dyndns.org/software/galleryadd/"
SRC_URI="http://iainlea.dyndns.org/software/galleryadd/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND="dev-perl/libwww-perl
		 virtual/perl-Time-HiRes"
DEPEND=""

S="${WORKDIR}"

src_install() {
	dobin galleryadd.pl
}
