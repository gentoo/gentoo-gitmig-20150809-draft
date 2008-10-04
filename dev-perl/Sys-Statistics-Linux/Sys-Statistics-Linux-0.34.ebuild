# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sys-Statistics-Linux/Sys-Statistics-Linux-0.34.ebuild,v 1.3 2008/10/04 15:02:24 gentoofan23 Exp $

inherit perl-module

DESCRIPTION="Collect linux system statistics"
HOMEPAGE="http://search.cpan.org/~bloonix/"
SRC_URI="mirror://cpan/authors/id/B/BL/BLOONIX/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE="test"
SRC_TEST="do"

RDEPEND="dev-lang/perl
	dev-perl/UNIVERSAL-require"
DEPEND="${RDEPEND}
	dev-perl/module-build
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"
