# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-SubCalls/Test-SubCalls-0.05.ebuild,v 1.5 2006/08/05 23:55:43 mcummings Exp $

inherit perl-module

DESCRIPTION="Track the number of times subs are called"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/Hook-LexWrap-0.20
	dev-lang/perl"
RDEPEND="${DEPEND}"

