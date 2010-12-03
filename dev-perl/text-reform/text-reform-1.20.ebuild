# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/text-reform/text-reform-1.20.ebuild,v 1.3 2010/12/03 00:56:40 xmw Exp $

EAPI=2

MODULE_AUTHOR=CHORNY
MY_PN=Text-Reform
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Manual text wrapping and reformatting"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod )"

SRC_TEST=do
