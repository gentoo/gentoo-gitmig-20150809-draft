# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libwww-perl/libwww-perl-5.76.ebuild,v 1.1 2003/12/22 22:36:47 rac Exp $

inherit perl-module

DESCRIPTION="A collection of Perl Modules for the WWW"
SRC_URI="http://cpan.org/modules/by-module/WWW/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/WWW/${P}.readme"
IUSE="ssl"
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa ~arm"

newdepend ">=dev-perl/libnet-1.0703
	>=dev-perl/HTML-Parser-3.13
	>=dev-perl/URI-1.0.9
	>=dev-perl/Digest-MD5-2.12
	>=dev-perl/MIME-Base64-2.12
	ssl? ( dev-perl/Crypt-SSLeay )"

src_compile() {
	yes "" | perl Makefile.PL ${myconf} \
		PREFIX=${D}/usr INSTALLDIRS=vendor
	perl-module_src_test || die
}
