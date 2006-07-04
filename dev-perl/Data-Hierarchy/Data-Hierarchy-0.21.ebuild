# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Hierarchy/Data-Hierarchy-0.21.ebuild,v 1.9 2006/07/04 07:36:55 ian Exp $

inherit perl-module

DESCRIPTION="Data::Hierarchy - Handle data in a hierarchical structure"
SRC_URI="mirror://cpan/authors/id/C/CL/CLKAO/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Data/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha ~amd64 ia64 ~mips ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Clone"
RDEPEND="${DEPEND}"