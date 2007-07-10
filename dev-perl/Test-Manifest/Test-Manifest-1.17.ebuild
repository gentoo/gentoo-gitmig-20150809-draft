# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Manifest/Test-Manifest-1.17.ebuild,v 1.6 2007/07/10 23:33:33 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Interact with a t/test_manifest file"
SRC_URI="mirror://cpan/authors/id/B/BD/BDFOY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~bdfoy/${P}/"

IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha amd64 ~ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"

SRC_TEST="do"

DEPEND="dev-lang/perl"
