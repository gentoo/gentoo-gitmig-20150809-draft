# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-Base64/MIME-Base64-2.12-r1.ebuild,v 1.4 2002/07/25 04:13:26 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A base64/quoted-printable encoder/decoder Perl Modules"
SRC_URI="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/MIME/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/MIME/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86"
