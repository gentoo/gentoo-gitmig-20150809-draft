# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/gitweb/gitweb-248.ebuild,v 1.2 2005/10/20 20:21:51 ferdy Exp $

inherit webapp

DESCRIPTION="Web interface to GIT repositories"
HOMEPAGE="http://git.or.cz/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl
>=dev-util/git-0.99.8f"

src_install() {
	webapp_src_preinst
	dodoc README "${FILESDIR}/README.gentoo"
	rm -f README

	sed -i \
		-e 's:^\(my $projectroot = *\).*$:\1"/var/git";:g' \
		-e 's:indextext\.html:index/text.html:g' \
		gitweb.cgi || die "sed failed"

	chmod +x gitweb.cgi

	cp gitweb.cgi ${D}${MY_HTDOCSDIR}

	webapp_postinst_txt en "${FILESDIR}/postinstall-en.txt"
	webapp_src_install
}
