# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-SimpleObject/XML-SimpleObject-0.53.ebuild,v 1.1 2003/04/24 23:39:08 rac Exp $

inherit perl-module

VERSION=0.53
S=${WORKDIR}/XML-SimpleObject${VERSION}
DESCRIPTION="A Perl XML Simple package."
SRC_URI="http://www.cpan.org/modules/by-module/XML/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/XML/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}
	>=dev-perl/XML-Parser-2.30
	>=dev-perl/XML-LibXML-1.54"

