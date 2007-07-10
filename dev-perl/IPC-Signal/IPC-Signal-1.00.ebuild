# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IPC-Signal/IPC-Signal-1.00.ebuild,v 1.10 2007/07/10 23:33:29 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Translate signal names to/from numbers"
SRC_URI="mirror://cpan/authors/id/R/RO/ROSCH/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rosch/"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 sparc x86"

DEPEND="dev-lang/perl"
