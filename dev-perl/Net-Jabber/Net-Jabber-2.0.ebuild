# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Jabber/Net-Jabber-2.0.ebuild,v 1.2 2005/03/27 14:24:27 kloeri Exp $

inherit perl-module

DESCRIPTION="Jabber Perl library"
SRC_URI="mirror://cpan/authors/id/R/RE/REATMON/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~reatmon/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~ppc ~sparc alpha"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/XML-Stream
	dev-perl/Net-XMPP
	dev-perl/Digest-SHA1"
