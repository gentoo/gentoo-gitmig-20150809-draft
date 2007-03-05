# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-Wav/Audio-Wav-0.06.ebuild,v 1.10 2007/03/05 11:11:36 ticho Exp $

inherit perl-module

DESCRIPTION="Modules for reading & writing Microsoft WAV files."
SRC_URI="mirror://cpan/authors/id/N/NP/NPESKETT/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~npeskett"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""
DEPEND="dev-lang/perl"

SRC_TEST="do"
