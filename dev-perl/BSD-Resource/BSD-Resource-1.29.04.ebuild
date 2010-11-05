# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/BSD-Resource/BSD-Resource-1.29.04.ebuild,v 1.3 2010/11/05 13:07:00 hwoarang Exp $

EAPI=2

inherit versionator
MODULE_AUTHOR=JHI
MY_P=${PN}-$(delete_version_separator 2)
inherit perl-module

DESCRIPTION="Perl module for BSD process resource limit and priority functions"

SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~sparc x86"
IUSE=""

SRC_TEST="do"

S=${WORKDIR}/${MY_P}
