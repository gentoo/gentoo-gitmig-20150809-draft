# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MogileFS-Utils/MogileFS-Utils-2.14.ebuild,v 1.1 2009/01/13 19:53:32 robbat2 Exp $

MODULE_AUTHOR="DORMANDO"
inherit perl-module

DESCRIPTION="Server for the MogileFS distributed file system"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="virtual/perl-Compress-Zlib
		dev-perl/libwww-perl
		>=dev-perl/MogileFS-Client-1.07
		dev-lang/perl"
