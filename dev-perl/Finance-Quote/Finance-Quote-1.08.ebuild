# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Finance-Quote/Finance-Quote-1.08.ebuild,v 1.4 2004/03/25 20:59:34 gustavoz Exp $

inherit perl-module

MY_P=${P/.3_/c-}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl Finance-Quote Module"
HOMEPAGE="http://www.cpan.org/modules/by-module/Finance/${MY_P}.readme"
SRC_URI="http://www.cpan.org/modules/by-module/Finance/${MY_P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc sparc"

DEPEND="dev-perl/libwww-perl
	dev-perl/HTML-TableExtract"

mydoc="TODO"
