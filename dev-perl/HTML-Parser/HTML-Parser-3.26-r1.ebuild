# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Parser/HTML-Parser-3.26-r1.ebuild,v 1.2 2002/07/31 13:10:12 cselkirk Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A HTML parser Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/HTML/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/HTML/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc"

DEPEND="${DEPEND}
	>=dev-perl/HTML-Tagset-3.03"

mydoc="ANNOUNCEMENT TODO"
