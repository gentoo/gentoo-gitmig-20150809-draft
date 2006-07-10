# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-Mixer/Audio-Mixer-0.7.ebuild,v 1.6 2006/07/10 14:27:05 agriffis Exp $

inherit perl-module

DESCRIPTION="Perl extension for Sound Mixer control"
HOMEPAGE="http://search.cpan.org/~sergey/${P}/"
SRC_URI="mirror://cpan/authors/id/S/SE/SERGEY/${P}.tar.gz"

LICENSE="Artistic"
#LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ia64 ~ppc sparc x86"
IUSE=""

# Dont' enable tests unless your working without a sandbox - expects to write to /dev/mixer
#SRC_TEST="do"
