# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-Wav/Audio-Wav-0.02.ebuild,v 1.15 2006/07/03 20:20:09 ian Exp $

inherit perl-module

DESCRIPTION="Modules for reading & writing Microsoft WAV files."
SRC_URI="mirror://cpan/authors/id/N/NP/NPESKETT/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Audio/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha hppa ia64"
IUSE=""
DEPEND="dev-perl/Audio-Tools"
RDEPEND="${DEPEND}"
