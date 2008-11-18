# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/tagged/tagged-0.40.ebuild,v 1.15 2008/11/18 15:52:26 tove Exp $

inherit perl-module

DESCRIPTION="Modules for reading tags of MP3 audio files"
HOMEPAGE="http://search.cpan.org/~thogee/"
SRC_URI="mirror://cpan/authors/id/T/TH/THOGEE/${P}.tar.gz"
LICENSE="Artistic"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
SLOT="0"
IUSE=""

DEPEND="virtual/perl-Compress-Zlib
	dev-lang/perl"
