# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/URI/URI-1.31.ebuild,v 1.7 2004/10/19 08:07:35 absinthe Exp $

inherit perl-module

DESCRIPTION="A URI Perl Module"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/URI/${P}.readme"
SRC_URI="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/URI/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~ppc sparc mips alpha ~arm hppa amd64 ~ia64 ~s390"
IUSE=""

DEPEND="dev-perl/MIME-Base64"

mydoc="rfc2396.txt"
