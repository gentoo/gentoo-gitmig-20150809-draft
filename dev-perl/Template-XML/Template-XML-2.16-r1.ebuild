# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Template-XML/Template-XML-2.16-r1.ebuild,v 1.2 2006/08/27 21:12:39 weeve Exp $

inherit perl-module eutils

DESCRIPTION="XML plugins for the Template Toolkit"
SRC_URI="mirror://cpan/modules/by-module/Template/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/dist/${P}/"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl
	>=dev-perl/Template-Toolkit-2.15-r1
	dev-perl/XML-DOM
	dev-perl/XML-Parser
	dev-perl/XML-RSS
	dev-perl/XML-Simple
	dev-perl/XML-XPath"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/bug-144689-branch-2.16.patch
}
