# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-MMagic/File-MMagic-1.20.ebuild,v 1.1 2003/07/31 13:51:42 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl Image-Info Module"
SRC_URI="http://search.cpan.org/CPAN/authors/id/K/KN/KNOK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/File/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
