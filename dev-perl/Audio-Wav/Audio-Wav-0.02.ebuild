# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-Wav/Audio-Wav-0.02.ebuild,v 1.4 2002/12/15 10:44:12 bjb Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Modules for reading & writing Microsoft WAV files."
SRC_URI="http://www.cpan.org/modules/by-module/Audio/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Audio/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
DEPEND="dev-perl/Audio-Tools"
