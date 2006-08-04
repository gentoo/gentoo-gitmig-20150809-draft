# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Rar/Archive-Rar-1.9.ebuild,v 1.18 2006/08/04 22:21:52 mcummings Exp $

inherit perl-module

DESCRIPTION="Archive::Rar - Interface with the rar command"
HOMEPAGE="http://www.cpan.org/modules/by-module/Acrhive/${P}.readme"
SRC_URI="mirror://cpan/authors/id/J/JM/JMBO/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~mips ppc sparc x86"
IUSE=""
DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
