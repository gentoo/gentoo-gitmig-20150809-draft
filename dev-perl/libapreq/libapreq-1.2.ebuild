# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libapreq/libapreq-1.2.ebuild,v 1.5 2005/01/04 14:39:27 mcummings Exp $

inherit perl-module

DESCRIPTION="A Apache Request Perl Module"
SRC_URI="mirror://cpan/authors/id/J/JO/JOESUF/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~joesuf/${P}/"

SLOT="0"
LICENSE="Apache-1.1 as-is"
KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND="${DEPEND}
	>=sys-apps/sed-4
	dev-perl/Apache-Test
	<dev-perl/mod_perl-1.99"

mydoc="TODO"
