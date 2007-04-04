# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/gitweb/gitweb-1.5.1.ebuild,v 1.1 2007/04/04 11:09:55 ferdy Exp $

inherit webapp

GIT_VERSION="${PV}"

DESCRIPTION="Web interface to GIT repositories"
HOMEPAGE="http://git.or.cz/"
SRC_URI="mirror://kernel/software/scm/git/git-${GIT_VERSION}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl
>=dev-util/git-${PV}"

S="${WORKDIR}"/git-${GIT_VERSION}/gitweb

src_compile() {
	sed -i \
		-e 's~^\(GITWEB_PROJECTROOT =\).*$~\1 /var/git~g' \
		-e 's~^\(GITWEB_SITE_HEADER =\).*$~\1 header.html~g' \
		-e 's~^\(GITWEB_SITE_FOOTER =\).*$~\1 footer.html~g' \
		../Makefile || die "failed to sed Makefile"
	emake -C .. prefix=/usr gitweb/gitweb.cgi || die "emake failed"
}

src_install() {
	webapp_src_preinst
	dodoc README "${FILESDIR}"/README.gentoo
	rm -f README

	cp gitweb.{cgi,css} git-{favicon,logo}.png "${D}/${MY_HTDOCSDIR}"
	cp "${FILESDIR}"/apache.htaccess "${D}/${MY_HTDOCSDIR}"/.htaccess

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_src_install
}
