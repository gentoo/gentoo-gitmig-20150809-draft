# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-GDOME/XML-GDOME-0.86.ebuild,v 1.18 2006/12/11 10:28:21 yuval Exp $

inherit perl-module eutils

DESCRIPTION="Provides the DOM Level 2 Core API for accessing XML documents"
SRC_URI="mirror://cpan/authors/id/T/TJ/TJMATHER/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/T/TJ/TJMATHER/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
IUSE=""

DEPEND=">=dev-libs/gdome2-0.7.2
		!=dev-libs/gdome2-0.8.1-r1
		dev-perl/XML-LibXML-Common
		dev-perl/XML-SAX
		dev-lang/perl"
RDEPEND="${DEPEND}"

