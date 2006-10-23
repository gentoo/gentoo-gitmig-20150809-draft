# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cache-Simple-TimedExpiry/Cache-Simple-TimedExpiry-0.26.ebuild,v 1.6 2006/10/23 19:42:58 gustavoz Exp $

inherit perl-module

DESCRIPTION="A lightweight cache with timed expiration"
HOMEPAGE="http://search.cpan.org/~jesse/${P}/"
SRC_URI="mirror://cpan/authors/id/J/JE/JESSE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc ~x86"
IUSE=""

SRC_TEST="do"
DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
