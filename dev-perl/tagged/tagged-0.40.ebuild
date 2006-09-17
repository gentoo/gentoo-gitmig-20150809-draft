# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/tagged/tagged-0.40.ebuild,v 1.12 2006/09/17 01:51:34 mcummings Exp $

inherit perl-module

DESCRIPTION="Modules for reading tags of MP3 audio files"
HOMEPAGE="http://www.cpan.org/~thogee/${P}/"
SRC_URI="mirror://cpan/authors/id/T/TH/THOGEE/${P}.tar.gz"
LICENSE="Artistic"
KEYWORDS="~amd64 ia64 ~ppc sparc x86"
SLOT="0"
IUSE=""

DEPEND="dev-perl/Compress-Zlib
	dev-lang/perl"
RDEPEND="${DEPEND}"

