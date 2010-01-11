# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Spiffy/Spiffy-0.30.ebuild,v 1.16 2010/01/11 20:15:02 grobian Exp $

inherit perl-module

DESCRIPTION="Spiffy Perl Interface Framework For You"
HOMEPAGE="http://search.cpan.org/~ingy/"
SRC_URI="mirror://cpan/authors/id/I/IN/INGY/${P}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-lang/perl-5.6.1"
