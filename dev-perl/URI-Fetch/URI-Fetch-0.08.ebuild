# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/URI-Fetch/URI-Fetch-0.08.ebuild,v 1.2 2008/11/18 15:42:10 tove Exp $

MODULE_AUTHOR=BTROTT
inherit perl-module

DESCRIPTION="Smart URI fetching/caching"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/libwww-perl
	dev-perl/Class-ErrorHandler
	virtual/perl-Storable
	dev-perl/URI
	dev-perl/Cache
	virtual/perl-Compress-Zlib"

PREFER_BUILDPL=no
SRC_TEST=no
