# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-SAX/XML-SAX-0.15.ebuild,v 1.1 2007/02/17 15:33:25 mcummings Exp $

inherit perl-module eutils

DESCRIPTION="Perl module for using and building Perl SAX2 XML parsers, filters, and drivers"
SRC_URI="mirror://cpan/authors/id/G/GR/GRANTM/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~grantm/"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-perl/XML-NamespaceSupport-1.04
	>=dev-libs/libxml2-2.4.1
	>=sys-apps/sed-4
	dev-lang/perl"

SRC_TEST="do"

src_unpack() {
	local installvendorlib
	eval $(perl '-V:installvendorlib')
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s,\(-MXML::SAX\),-I${D}/${installvendorlib} \1," \
		Makefile.PL || die
	epatch "${FILESDIR}"/encodings.patch
}
