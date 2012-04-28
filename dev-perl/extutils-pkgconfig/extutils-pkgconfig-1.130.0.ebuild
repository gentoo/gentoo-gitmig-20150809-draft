# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/extutils-pkgconfig/extutils-pkgconfig-1.130.0.ebuild,v 1.1 2012/04/28 07:29:22 tove Exp $

EAPI=4

MY_PN=ExtUtils-PkgConfig
MODULE_AUTHOR=XAOC
MODULE_VERSION=1.13
inherit perl-module

DESCRIPTION="Simplistic perl interface to pkg-config"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

DEPEND="dev-util/pkgconfig"
RDEPEND="${DEPEND}"

SRC_TEST="do"
