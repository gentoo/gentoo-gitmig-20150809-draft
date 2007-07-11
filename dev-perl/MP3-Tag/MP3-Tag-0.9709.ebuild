# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MP3-Tag/MP3-Tag-0.9709.ebuild,v 1.3 2007/07/11 20:11:32 armin76 Exp $

IUSE=""

inherit perl-module eutils

DESCRIPTION="Tag - Module for reading tags of mp3 files"
HOMEPAGE="http://search.cpan.org/~ilyaz/"
SRC_URI="mirror://cpan/modules/by-authors/id/I/IL/ILYAZ/modules/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
SRC_TEST="do"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-makefile.patch
}

DEPEND="dev-lang/perl"
