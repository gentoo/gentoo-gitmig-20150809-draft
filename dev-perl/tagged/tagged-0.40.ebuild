# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/tagged/tagged-0.40.ebuild,v 1.14 2007/01/19 16:01:46 mcummings Exp $

inherit perl-module

DESCRIPTION="Modules for reading tags of MP3 audio files"
HOMEPAGE="http://search.cpan.org/~thogee/"
SRC_URI="mirror://cpan/authors/id/T/TH/THOGEE/${P}.tar.gz"
LICENSE="Artistic"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
SLOT="0"
IUSE=""

DEPEND="dev-perl/Compress-Zlib
	dev-lang/perl"
