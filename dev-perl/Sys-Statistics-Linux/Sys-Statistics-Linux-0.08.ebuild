# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sys-Statistics-Linux/Sys-Statistics-Linux-0.08.ebuild,v 1.4 2007/06/08 03:50:13 ticho Exp $

inherit perl-module

DESCRIPTION="Collect linux system statistics"
HOMEPAGE="http://search.cpan.org/~bloonix/"
SRC_URI="mirror://cpan/authors/id/B/BL/BLOONIX/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND="dev-perl/module-build
	${RDEPEND}"

SRC_TEST="do"
