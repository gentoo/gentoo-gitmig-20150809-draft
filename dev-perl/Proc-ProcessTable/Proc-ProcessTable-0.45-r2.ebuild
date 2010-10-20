# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Proc-ProcessTable/Proc-ProcessTable-0.45-r2.ebuild,v 1.2 2010/10/20 22:58:06 hwoarang Exp $

EAPI="2"

MODULE_AUTHOR=DURIST
inherit perl-module

DESCRIPTION="Unix process table information"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="virtual/perl-Storable"

PATCHES=(
	"${FILESDIR}/amd64_canonicalize_file_name_definition.patch"
	"${FILESDIR}/0.45-pthread.patch"
	"${FILESDIR}/0.45-fix-format-errors.patch"
)
