# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/Apache-Gallery/Apache-Gallery-0.8.ebuild,v 1.3 2004/11/08 08:41:39 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Apache gallery for mod_perl"
SRC_URI="http://cpan.org/modules/by-module/Apache/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/LEGART/${P}"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~sparc"
IUSE=""


DEPEND="${DEPEND}
	>=dev-perl/libapreq-1.0
	>=media-libs/imlib2-1.0.6-r1
	>=dev-perl/mod_perl-1.27-r1
	>=dev-perl/ImageInfo-1.04-r2
	>=dev-perl/ImageSize-2.99-r1
	dev-perl/Image-Imlib2
	>=dev-perl/CGI-2.78-r3
	>=dev-perl/CGI-FastTemplate-1.09
	>=dev-perl/Parse-RecDescent-1.80-r3
	dev-perl/URI
	dev-perl/text-template
	>=dev-perl/Inline-0.43-r1
	virtual/x11"



src_install() {
	mydoc="INSTALL"

	perl-module_src_install

	insinto /home/httpd/icons
	doins htdocs/*.png

	insinto /etc/apache/gallery/templates
	doins templates/*.tpl

	insinto /etc/apache/conf
	doins ${FILESDIR}/apache-gallery.conf
}

pkg_postinst() {
	install -d -o root -g root -m0755 ${ROOT}/etc/apache/conf/ssl

	einfo
	einfo "Execute \"ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\""
	einfo "to have your apache.conf auto-updated."
	einfo "You should then edit your /etc/apache/conf/apache-gallery.conf file to suit."
	einfo
}

pkg_config() {
	echo "Include  conf/apache-gallery.conf" \
	>> ${ROOT}/etc/apache/conf/apache.conf
}
