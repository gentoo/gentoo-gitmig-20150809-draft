# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Jabber/Net-Jabber-1.30.ebuild,v 1.1 2004/06/06 15:16:37 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Jabber Perl library"
SRC_URI="http://search.cpan.org/CPAN/authors/id/R/RE/REATMON/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~reatmon/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"

SRC_TEST="do"

DEPEND="dev-perl/XML-Stream
	>=dev-perl/Digest-SHA1"
