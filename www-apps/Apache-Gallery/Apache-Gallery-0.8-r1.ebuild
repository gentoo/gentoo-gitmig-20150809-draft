# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/Apache-Gallery/Apache-Gallery-0.8-r1.ebuild,v 1.2 2004/11/08 08:41:39 mr_bones_ Exp $

inherit perl-module webapp

DESCRIPTION="Apache gallery for mod_perl"
SRC_URI="http://cpan.org/modules/by-module/Apache/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/LEGART/${P}"

LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~sparc"
IUSE="apache2"

DEPEND="${DEPEND}
	>=dev-perl/libapreq-1.0
	>=media-libs/imlib2-1.0.6-r1
	>=dev-perl/mod_perl-1.27-r1
	>=dev-perl/ImageInfo-1.04-r2
	>=dev-perl/ImageSize-2.99-r1
	dev-perl/Image-Imlib2
	>=dev-perl/CGI-2.93
	>=dev-perl/CGI-FastTemplate-1.09
	>=dev-perl/Parse-RecDescent-1.80-r3
	dev-perl/URI
	dev-perl/text-template
	>=dev-perl/Inline-0.43-r1
	virtual/x11
	!apache2? ( >=net-www/apache-1.3.26-r2 )
	apache2? ( >=net-www/apache-2.0.43-r1 ) "

src_install() {
	webapp_src_preinst
	mydoc="INSTALL"

	perl-module_src_install

	insinto ${MY_ICONSDIR}
	doins htdocs/*.png

	dodir ${MY_HOSTROOTDIR}/${PN}/templates/default
	dodir ${MY_HOSTROOTDIR}/${PN}/templates/new

	insinto ${MY_HOSTROOTDIR}/${PN}/templates/default
	doins templates/default/*.tpl
	insinto ${MY_HOSTROOTDIR}/${PN}/templates/new
	doins templates/default/*.tpl

	if use apache2; then
		insinto /etc/apache2/conf/modules.d
		doins ${FILESDIR}/76_apache-gallery.conf
	else
		insinto /etc/apache/conf/addon-modules
		doins ${FILESDIR}/apache-gallery.conf
	fi
	webapp_src_install
}

pkg_postinst() {
	if use apache2; then
		einfo
		einfo "You should edit your /etc/apache2/conf/modules.d/76_apache-gallery.conf file to suit."
	else
		einfo
		einfo "Execute \"ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\""
		einfo "to have your apache.conf auto-updated."
		einfo "You should then edit your /etc/apache/conf/addon-modules/apache-gallery.conf file to suit."
		einfo
	fi
	webapp_pkg_postinst
}

pkg_config() {
	use apache2 || \
		echo "Include  /etc/apache/conf/addon-modules/apache-gallery.conf" \
			>> ${ROOT}/etc/apache/conf/apache.conf
}
