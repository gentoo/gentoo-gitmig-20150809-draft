# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Danga-Socket/Danga-Socket-1.57.ebuild,v 1.1 2007/04/30 05:51:36 robbat2 Exp $

inherit perl-module

DESCRIPTION="A non-blocking socket object; uses epoll()"
HOMEPAGE="http://search.cpan.org/search?query=Danga-Socket&mode=dist"
SRC_URI="mirror://cpan/authors/id/B/BR/BRADFITZ/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-perl/Sys-Syscall
		dev-lang/perl"
mydoc="CHANGES"
SRC_TEST="do"
