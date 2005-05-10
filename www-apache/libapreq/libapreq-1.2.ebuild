# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/libapreq/libapreq-1.2.ebuild,v 1.1 2005/05/10 00:12:19 beu Exp $

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
	<www-apache/mod_perl-1.99"

mydoc="TODO"
