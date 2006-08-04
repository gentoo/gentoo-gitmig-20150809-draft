# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-Tools/Audio-Tools-0.01.ebuild,v 1.16 2006/08/04 22:29:17 mcummings Exp $

inherit perl-module

DESCRIPTION="Tools required by some Audio modules"
SRC_URI="mirror://cpan/authors/id/N/NP/NPESKETT/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~npeskett/${P}"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha hppa ia64 ppc64"
IUSE=""
DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
