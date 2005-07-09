# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Finance-Quote/Finance-Quote-1.08-r1.ebuild,v 1.7 2005/07/09 23:20:23 swegener Exp $

inherit perl-module eutils

DESCRIPTION="The Perl Finance-Quote Module"
HOMEPAGE="http://search.cpan.org/~pjf/${P}/"
SRC_URI="mirror://cpan/authors/id/P/PJ/PJF/${P}.tar.gz"

IUSE=""

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc alpha"

SRC_TEST="do"

DEPEND="dev-perl/libwww-perl
	dev-perl/HTML-TableExtract"

mydoc="TODO"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-tase.patch
}
