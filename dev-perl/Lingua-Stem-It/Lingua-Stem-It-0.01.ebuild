# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-Stem-It/Lingua-Stem-It-0.01.ebuild,v 1.2 2005/01/22 15:26:57 mcummings Exp $

inherit perl-module

DESCRIPTION="Porter's stemming algorithm for Italian"
HOMEPAGE="http://search.cpan.org/~acalpini/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AC/ACALPINI/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""

SRC_TEST="do"
