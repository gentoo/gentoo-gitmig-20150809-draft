# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/BSD-Resource/BSD-Resource-1.29.01.ebuild,v 1.1 2008/12/08 07:36:36 robbat2 Exp $

inherit versionator
MODULE_AUTHOR=JHI
MY_P=${PN}-$(delete_version_separator 2)
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Perl module for BSD process resource limit and priority functions"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""
SRC_TEST="do"
DEPEND="dev-lang/perl"
