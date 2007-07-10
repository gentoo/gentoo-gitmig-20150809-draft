# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Modem-Vgetty/Modem-Vgetty-0.03.ebuild,v 1.4 2007/07/10 23:33:30 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Interface to voice modems using vgetty"
HOMEPAGE="http://search.cpan.org/~yenya/"
SRC_URI="mirror://cpan/authors/id/Y/YE/YENYA/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ~x86"

SRC_TEST="do"
