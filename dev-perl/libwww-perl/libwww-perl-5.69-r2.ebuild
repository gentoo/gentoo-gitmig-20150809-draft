# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libwww-perl/libwww-perl-5.69-r2.ebuild,v 1.9 2004/10/16 23:57:25 rac Exp $

inherit perl-module eutils

DESCRIPTION="A collection of Perl Modules for the WWW"
SRC_URI="http://cpan.org/modules/by-module/WWW/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/WWW/${P}.readme"
IUSE="ssl"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ~ppc sparc alpha hppa ~mips"

DEPEND=">=dev-perl/libnet-1.0703
	>=dev-perl/HTML-Parser-3.13
	>=dev-perl/URI-1.0.9
	>=dev-perl/Digest-MD5-2.12
	>=dev-perl/MIME-Base64-2.12
	ssl? ( dev-perl/Crypt-SSLeay )"

mydoc="TODO"

src_compile() {
	yes "" | perl Makefile.PL ${myconf} \
		PREFIX=${D}/usr INSTALLDIRS=vendor
	perl-module_src_test || export TEST_WARN="1"
}

pkg_postinst() {
	if [ "${TEST_WARN}" == "1" ]; then
		echo ""
		eerror "Not all of libwww-perl's internal tests passed. This"
		eerror "is generally caused by a misoconfigured network setting"
		eerror "and not by a problem with libwww-perl itself. Some "
		eerror "factors include network connectivity, proxies, firewalls,"
		eerror "and bad /etc/hosts files, to name a few. If you "
		eerror "have trouble using libwww-perl, please contact us at"
		eerror "http://bugs.gentoo.org/"
		echo ""
		epause 5
	fi
	perl-module_pkg_postinst
}
