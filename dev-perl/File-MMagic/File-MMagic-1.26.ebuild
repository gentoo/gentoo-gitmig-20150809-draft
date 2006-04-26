# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-MMagic/File-MMagic-1.26.ebuild,v 1.1 2006/04/26 00:14:35 mcummings Exp $

inherit perl-module

DESCRIPTION="The Perl Image-Info Module"
SRC_URI="mirror://cpan/authors/id/K/KN/KNOK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/File/${P}.readme"
SRC_TEST="do"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
