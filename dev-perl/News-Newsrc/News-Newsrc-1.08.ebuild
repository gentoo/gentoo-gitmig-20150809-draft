# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/News-Newsrc/News-Newsrc-1.08.ebuild,v 1.5 2004/10/16 23:57:22 rac Exp $

inherit perl-module

DESCRIPTION="Manage newsrc files"
SRC_URI="http://cpan.org/modules/by-module/News/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/News/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~ppc alpha ~sparc ~amd64 ~hppa"
SRC_TEST="do"
DEPEND=">=dev-perl/Set-IntSpan-1.07"

