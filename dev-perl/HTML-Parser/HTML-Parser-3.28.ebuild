# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Parser/HTML-Parser-3.28.ebuild,v 1.14 2005/04/02 05:16:54 geoman Exp $

inherit perl-module

DESCRIPTION="Parse <HEAD> section of HTML documents"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${P}.tar.gz"
HOMEPAGE="http://searc.cpan.org/~gaas/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc ~sparc alpha hppa mips ia64"
IUSE=""

DEPEND="${DEPEND}
	>=dev-perl/HTML-Tagset-3.03"

mydoc="ANNOUNCEMENT TODO"

src_compile() {
	echo n |perl Makefile.PL ${myconf} \
	PREFIX=${D}/usr
	make || test
}
