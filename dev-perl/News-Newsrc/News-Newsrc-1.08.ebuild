# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/News-Newsrc/News-Newsrc-1.08.ebuild,v 1.1 2003/12/24 05:10:26 rac Exp $

inherit perl-module

DESCRIPTION="Manage newsrc files"
SRC_URI="http://cpan.org/modules/by-module/News/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/News/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~amd64 ~hppa"
SRC_TEST="do"
newdepend ">=dev-perl/Set-IntSpan-1.07"

