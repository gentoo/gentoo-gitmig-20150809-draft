# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libwww-perl/libwww-perl-5.69-r1.ebuild,v 1.6 2005/01/04 14:43:15 mcummings Exp $

inherit perl-module

DESCRIPTION="A collection of Perl Modules for the WWW"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~gaas/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc ~sparc alpha hppa"
IUSE="ssl"

DEPEND="${DEPEND}
	>=dev-perl/libnet-1.0703
	>=dev-perl/HTML-Parser-3.13
	>=dev-perl/URI-1.0.9
	>=dev-perl/Digest-MD5-2.12
	>=dev-perl/MIME-Base64-2.12
	ssl? ( dev-perl/Crypt-SSLeay )"

mydoc="TODO"

src_compile() {

	yes "" | perl Makefile.PL ${myconf} \
		PREFIX=${D}/usr
}
