# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/BSD-Resource/BSD-Resource-1.25.ebuild,v 1.1 2006/04/24 00:35:28 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl module for BSD process resource limit and priority functions"
HOMEPAGE="http://www.cpan.org/modules/by-module/BSD/${P}.readme"
SRC_URI="mirror://cpan/authors/id/J/JH/JHI/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""
SRC_TEST="do"

