# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/URI/URI-1.18-r1.ebuild,v 1.5 2003/02/27 23:02:28 gmsoft Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A URI Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/URI/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/URI/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc sparc alpha hppa"

DEPEND="${DEPEND}
	dev-perl/MIME-Base64"

mydoc="rfc2396.txt"
