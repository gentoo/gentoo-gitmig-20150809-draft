# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-SAX/XML-SAX-0.12.ebuild,v 1.11 2005/04/11 19:01:20 corsair Exp $

inherit perl-module

DESCRIPTION="Perl module for using and building Perl SAX2 XML parsers, filters, and drivers"
SRC_URI="mirror://cpan/authors/id/M/MS/MSERGEANT/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~msergeant/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha ~mips ~ppc64"
IUSE=""

DEPEND="${DEPEND}
	>=dev-perl/XML-NamespaceSupport-1.04
	>=dev-libs/libxml2-2.4.1
	>=sys-apps/sed-4"

src_unpack() {
	local installvendorlib
	eval $(perl '-V:installvendorlib')
	unpack ${A}
	sed -i -e "s,\(-MXML::SAX\),-I${D}/${installvendorlib} \1," ${S}/Makefile.PL
}

