# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Term-ANSIColor/Term-ANSIColor-2.02.ebuild,v 1.1 2009/09/01 16:04:59 tove Exp $

EAPI=2

MY_PN="ANSIColor"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"
MODULE_AUTHOR=RRA
inherit perl-module

DESCRIPTION="Color screen output using ANSI escape sequences."

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"
