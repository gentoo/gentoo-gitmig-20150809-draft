# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-Wav/Audio-Wav-0.06.ebuild,v 1.8 2006/10/20 18:50:33 kloeri Exp $

inherit perl-module

DESCRIPTION="Modules for reading & writing Microsoft WAV files."
SRC_URI="mirror://cpan/authors/id/N/NP/NPESKETT/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Audio/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc ~x86"
IUSE=""
DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

SRC_TEST="do"
