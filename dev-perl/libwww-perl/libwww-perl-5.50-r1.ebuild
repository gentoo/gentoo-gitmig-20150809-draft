# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libwww-perl/libwww-perl-5.50-r1.ebuild,v 1.4 2002/07/25 04:13:27 seemant Exp $


inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A collection of Perl Modules for the WWW"
SRC_URI="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/WWW/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/WWW/${P}.readme"

SLOT="0"
DEPEND="${DEPEND}
	>=dev-perl/libnet-1.0703
	>=dev-perl/HTML-Parser-3.13
	>=dev-perl/URI-1.0.9
	>=dev-perl/Digest-MD5-2.12"

SLOT="0"
LICENSE="Artistic"
