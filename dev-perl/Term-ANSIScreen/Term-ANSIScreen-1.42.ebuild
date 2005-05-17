# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ANSIScreen/Term-ANSIScreen-1.42.ebuild,v 1.8 2005/05/17 14:09:57 gustavoz Exp $

IUSE=""

inherit perl-module

DESCRIPTION="Terminal control using ANSI escape sequences."
SRC_URI="mirror://cpan/authors/id/A/AU/AUTRIJUS/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/CPAN/data/ANSIScreen/ANSIScreen.html"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ~ppc sparc"

SRC_TEST="do"
