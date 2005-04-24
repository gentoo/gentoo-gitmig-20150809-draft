# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Heap/Heap-0.50.ebuild,v 1.12 2005/04/24 03:14:37 hansmi Exp $

IUSE=""

inherit perl-module

CATEGORY="dev-perl"
DESCRIPTION="Heap - Perl extensions for keeping data partially sorted."
SRC_URI="http://www.cpan.org/modules/by-module/Heap/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Heap/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}"
