# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/tagged/tagged-0.40.ebuild,v 1.1 2004/09/04 11:18:45 mcummings Exp $

inherit perl-module

DESCRIPTION="Modules for reading tags of MP3 audio files"
HOMEPAGE="http://www.cpan.org/~thogee/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/T/TH/THOGEE/${P}.tar.gz"
LICENSE="Artistic"
KEYWORDS="~x86"
SLOT="0"

DEPEND="dev-perl/Compress-Zlib"
