# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/durep/durep-0.9.ebuild,v 1.1 2005/02/12 03:34:33 vapier Exp $

DESCRIPTION="A perl script designed for monitoring disk usage in a more visual way than du."
HOMEPAGE="http://www.hibernaculum.net/durep/"
SRC_URI="http://www.hibernaculum.net/download/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86" 
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/MLDBM"

src_install() {
	dobin durep || die
	doman durep.1
	dodoc BUGS CHANGES README THANKS
	dohtml -A cgi *.cgi *.css *.png
}
