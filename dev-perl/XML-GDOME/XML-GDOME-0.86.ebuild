# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-GDOME/XML-GDOME-0.86.ebuild,v 1.15 2006/07/05 13:24:07 ian Exp $

inherit perl-module eutils

DESCRIPTION="Provides the DOM Level 2 Core API for accessing XML documents"
SRC_URI="mirror://cpan/authors/id/T/TJ/TJMATHER/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/T/TJ/TJMATHER/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~ia64 ~ppc sparc x86"
IUSE=""

DEPEND=">=dev-libs/gdome2-0.7.2
		dev-perl/XML-LibXML-Common
		dev-perl/XML-SAX"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	! has_version '=dev-libs/gdome2-0.7*'  && epatch ${FILESDIR}/gdome-version-check.patch
}