# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Modem-Vgetty/Modem-Vgetty-0.03.ebuild,v 1.5 2009/01/17 22:28:40 robbat2 Exp $

inherit perl-module

DESCRIPTION="Interface to voice modems using vgetty"
HOMEPAGE="http://search.cpan.org/~yenya/"
SRC_URI="mirror://cpan/authors/id/Y/YE/YENYA/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ~x86"

SRC_TEST="do"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
