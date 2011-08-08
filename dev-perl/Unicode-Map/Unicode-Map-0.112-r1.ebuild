# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unicode-Map/Unicode-Map-0.112-r1.ebuild,v 1.3 2011/08/08 20:10:17 grobian Exp $

EAPI=2

MODULE_AUTHOR=MSCHWARTZ
inherit perl-module

DESCRIPTION="map charsets from and to utf16 code"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

SRC_TEST="do"
PATCHES=( "${FILESDIR}"/0.112-no-scripts.patch )
