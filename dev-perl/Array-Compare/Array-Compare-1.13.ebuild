# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Array-Compare/Array-Compare-1.13.ebuild,v 1.8 2006/07/14 13:44:34 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl extension for comparing arrays."
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/D/DA/DAVECROSS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ia64 ~ppc sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/module-build-0.28"
