# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-XPath/XML-XPath-1.13.ebuild,v 1.4 2004/01/21 14:14:19 gustavoz Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A XPath Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/XML/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/XML/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc sparc ~alpha ~mips"

DEPEND="${DEPEND}
	>=dev-perl/XML-Parser-2.30"
