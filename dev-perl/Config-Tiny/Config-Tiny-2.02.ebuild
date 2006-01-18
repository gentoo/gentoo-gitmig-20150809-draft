# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-Tiny/Config-Tiny-2.02.ebuild,v 1.3 2006/01/18 08:47:22 gmsoft Exp $

inherit perl-module

DESCRIPTION="Read/Write .ini style files with as little code as possible"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~adamk/${P}"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ~mips ~ppc ~ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="perl-core/Test-Simple"
