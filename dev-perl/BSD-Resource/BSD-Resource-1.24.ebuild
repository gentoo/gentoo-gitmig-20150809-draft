# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/BSD-Resource/BSD-Resource-1.24.ebuild,v 1.1 2004/06/05 14:29:39 mcummings Exp $

inherit perl-module

CATEGORY="dev-perl"
DESCRIPTION="Perl module for BSD process resource limit and priority functions"
HOMEPAGE="http://www.cpan.org/modules/by-module/BSD/${P}.readme"
SRC_URI="http://www.cpan.org/modules/by-module/BSD/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
SRC_TEST="do"
