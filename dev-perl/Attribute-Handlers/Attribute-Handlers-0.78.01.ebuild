# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Attribute-Handlers/Attribute-Handlers-0.78.01.ebuild,v 1.1 2005/03/14 11:55:15 mcummings Exp $

inherit perl-module eutils

MY_PV=${PV/.01/}
MY_P=${PN}-${MY_PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A Perl module for I/O on in-core objects like strings and arrays"
SRC_URI="mirror://cpan/authors/id/A/AB/ABERGMAN/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/author/ABERGMAN/${MY_P}/"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha ppc64"

myconf="${myconf} INSTALLDIRS=perl"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Attribute-Handlers-0.78_01.diff
}
