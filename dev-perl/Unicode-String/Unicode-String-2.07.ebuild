# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unicode-String/Unicode-String-2.07.ebuild,v 1.9 2005/05/25 14:16:17 mcummings Exp $

inherit perl-module

DESCRIPTION="String manipulation for Unicode strings"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~gaas/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND="${DEPEND}
	>=perl-core/MIME-Base64-2.11"
