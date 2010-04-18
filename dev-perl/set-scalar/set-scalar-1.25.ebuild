# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/set-scalar/set-scalar-1.25.ebuild,v 1.4 2010/04/18 12:07:55 maekke Exp $

EAPI=2

MODULE_AUTHOR=JHI
MY_PN=Set-Scalar
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Scalar set operations"

SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~m68k ~ppc ~s390 ~sh ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SRC_TEST="do"
