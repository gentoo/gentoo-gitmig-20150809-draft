# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libwww-perl/libwww-perl-5.69.ebuild,v 1.3 2003/06/24 14:56:29 agriffis Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A collection of Perl Modules for the WWW"
SRC_URI="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/WWW/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/WWW/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc ~sparc alpha ~hppa ~arm"

DEPEND="${DEPEND}
	>=dev-perl/libnet-1.0703
	>=dev-perl/HTML-Parser-3.13
	>=dev-perl/URI-1.0.9
	>=dev-perl/Digest-MD5-2.12
	>=dev-perl/MIME-Base64-2.12"

mydoc="TODO"

src_compile() {

	yes "" | perl Makefile.PL ${myconf} \
         PREFIX=${D}/usr
}
