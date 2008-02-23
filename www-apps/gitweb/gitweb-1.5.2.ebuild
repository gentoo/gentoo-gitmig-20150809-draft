# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/gitweb/gitweb-1.5.2.ebuild,v 1.3 2008/02/23 22:40:38 hollow Exp $

inherit webapp

DESCRIPTION="Web interface to GIT repositories"
HOMEPAGE="http://git.or.cz/"
SRC_URI="mirror://kernel/software/scm/git/git-${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl
	>=dev-util/git-${PV}"

need_httpd_cgi

S="${WORKDIR}"/git-${PV}/gitweb

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

	insinto "${MY_HTDOCSDIR}"
	doins gitweb.{cgi,css} git-{favicon,logo}.png
	newins "${FILESDIR}"/apache.htaccess .htaccess

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_src_install
}
