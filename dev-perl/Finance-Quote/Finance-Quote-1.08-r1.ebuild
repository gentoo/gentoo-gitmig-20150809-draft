# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Finance-Quote/Finance-Quote-1.08-r1.ebuild,v 1.8 2005/08/26 02:20:19 agriffis Exp $

inherit perl-module eutils

DESCRIPTION="The Perl Finance-Quote Module"
HOMEPAGE="http://search.cpan.org/~pjf/${P}/"
SRC_URI="mirror://cpan/authors/id/P/PJ/PJF/${P}.tar.gz"

IUSE=""

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"

SRC_TEST="do"

DEPEND="dev-perl/libwww-perl
	dev-perl/HTML-TableExtract"

mydoc="TODO"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-tase.patch
}
