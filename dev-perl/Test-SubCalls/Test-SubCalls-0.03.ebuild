# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-SubCalls/Test-SubCalls-0.03.ebuild,v 1.1 2006/04/20 02:26:51 mcummings Exp $

inherit perl-module

DESCRIPTION="Track the number of times subs are called"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/Hook-LexWrap-0.20"
