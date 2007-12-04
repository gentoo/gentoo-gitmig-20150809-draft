# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Jabber/Net-Jabber-2.0.ebuild,v 1.13 2007/12/04 20:38:55 corsair Exp $

inherit perl-module

DESCRIPTION="Jabber Perl library"
SRC_URI="mirror://cpan/authors/id/R/RE/REATMON/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~reatmon/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/XML-Stream
	dev-perl/Net-XMPP
	dev-perl/Digest-SHA1
	dev-lang/perl"
