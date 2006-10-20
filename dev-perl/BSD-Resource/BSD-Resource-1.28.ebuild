# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/BSD-Resource/BSD-Resource-1.28.ebuild,v 1.5 2006/10/20 18:51:27 kloeri Exp $

inherit perl-module

DESCRIPTION="Perl module for BSD process resource limit and priority functions"
HOMEPAGE="http://www.cpan.org/modules/by-module/BSD/${P}.readme"
SRC_URI="mirror://cpan/authors/id/J/JH/JHI/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc sparc ~x86"
IUSE=""
SRC_TEST="do"
DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
