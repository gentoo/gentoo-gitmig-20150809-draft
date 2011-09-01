# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cache-Cache/Cache-Cache-1.60.0.ebuild,v 1.1 2011/09/01 11:42:24 tove Exp $

EAPI=4

MODULE_AUTHOR=JSWARTZ
MODULE_VERSION=1.06
inherit perl-module

DESCRIPTION="Generic cache interface and implementations"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-solaris"
IUSE=""

RDEPEND=">=dev-perl/Digest-SHA1-2.02
	>=dev-perl/Error-0.15
	>=virtual/perl-Storable-1.0.14
	>=dev-perl/IPC-ShareLite-0.09"
DEPEND="${RDEPEND}"

export OPTIMIZE="$CFLAGS"
SRC_TEST="do"
