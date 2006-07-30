# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/gitweb/gitweb-267.ebuild,v 1.1 2006/07/30 11:05:33 ferdy Exp $

inherit webapp

GIT_VERSION="1.4.1.1"

DESCRIPTION="Web interface to GIT repositories"
HOMEPAGE="http://git.or.cz/"
SRC_URI="mirror://kernel/software/scm/git/git-${GIT_VERSION}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl
>=dev-util/git-1.4.0"

S="${WORKDIR}"/git-${GIT_VERSION}/gitweb

src_install() {
	webapp_src_preinst
	dodoc README "${FILESDIR}"/README.gentoo
	rm -f README

	sed -i \
		-e 's:^\(my $projectroot = *\).*$:\1"/var/git";:g' \
		-e 's:indextext\.html:index/text.html:g' \
		gitweb.cgi || die "sed failed"

	chmod +x gitweb.cgi

	cp gitweb.{cgi,css} ${D}${MY_HTDOCSDIR}

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_src_install
}
