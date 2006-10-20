# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MailTools/MailTools-1.74.ebuild,v 1.9 2006/10/20 19:54:30 kloeri Exp $

inherit perl-module

DESCRIPTION="Manipulation of electronic mail addresses"
SRC_URI="mirror://cpan/authors/id/M/MA/MARKOV/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~markov/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""
SRC_TEST="do"

DEPEND=">=virtual/perl-libnet-1.0703
	dev-lang/perl"
RDEPEND="${DEPEND}"

