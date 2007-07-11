# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-XMPP/Net-XMPP-1.02.ebuild,v 1.4 2007/07/11 20:41:55 armin76 Exp $

inherit perl-module

DESCRIPTION="Net::XMPP is a collection of Perl modules that provide a Perl Developer access to the XMPP protocol."
SRC_URI="mirror://cpan/authors/id/H/HA/HACKER/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~hacker/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~ppc ~ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

RDEPEND=">=dev-perl/XML-Stream-1.22
	dev-perl/Digest-SHA1
	dev-lang/perl"

DEPEND="dev-perl/module-build
	${RDEPEND}"
