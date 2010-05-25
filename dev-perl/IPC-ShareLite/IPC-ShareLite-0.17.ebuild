# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IPC-ShareLite/IPC-ShareLite-0.17.ebuild,v 1.5 2010/05/25 21:20:09 pacho Exp $

EAPI=2

MODULE_AUTHOR=ANDYA
inherit perl-module

DESCRIPTION="IPC::ShareLite module for perl"

SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ~ppc64 ~sparc ~x86 ~x86-solaris"
IUSE="test"

DEPEND="test? ( dev-perl/Test-Pod )"
RDEPEND=""

SRC_TEST=do
