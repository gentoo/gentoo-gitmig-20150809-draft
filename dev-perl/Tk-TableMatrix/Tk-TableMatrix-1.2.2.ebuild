# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tk-TableMatrix/Tk-TableMatrix-1.2.2.ebuild,v 1.9 2006/10/20 20:12:51 kloeri Exp $

inherit versionator perl-module eutils

MY_P="${PN}-$(delete_version_separator 2)"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Perl module for Tk-TableMatrix"
HOMEPAGE="http://search.cpan.org/author/CERNEY/${MY_P}"
SRC_URI="mirror://cpan/authors/id/C/CE/CERNEY/${MY_P}.tar.gz"

#SRC_TEST="do"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc ~x86"
IUSE=""

DEPEND="dev-perl/perl-tk
	dev-lang/perl"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/pTk-1.22.patch
}

