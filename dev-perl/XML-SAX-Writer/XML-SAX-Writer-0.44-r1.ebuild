# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-SAX-Writer/XML-SAX-Writer-0.44-r1.ebuild,v 1.3 2004/10/19 08:14:10 absinthe Exp $

inherit perl-module eutils

DESCRIPTION="SAX2 Writer"
SRC_URI="http://search.cpan.org/CPAN/authors/id/R/RB/RBERJON/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rberjon/${P}"

SRC_TEST="do"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc ~sparc alpha"
IUSE=""

DEPEND="${DEPEND}
	dev-perl/Text-Iconv
	dev-perl/XML-Filter-BufferText
	dev-perl/XML-SAX-Base
	>=dev-perl/XML-NamespaceSupport-1.04
	>=dev-libs/libxml2-2.4.1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Text-Iconv.patch || die
}
