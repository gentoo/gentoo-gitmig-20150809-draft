# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AppConfig/AppConfig-1.56-r1.ebuild,v 1.3 2004/06/25 00:06:00 agriffis Exp $

inherit perl-module eutils

DESCRIPTION="Application config (from ARGV, file, ...)"
HOMEPAGE="http://search.cpan.org/author/ABW/AppConfig-1.55/"
SRC_URI="http://www.cpan.org/authors/id/ABW/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 sparc alpha ~ppc"

DEPEND="dev-perl/Test-Simple"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/blockwhitespace.patch
}
