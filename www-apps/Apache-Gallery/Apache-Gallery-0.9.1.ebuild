# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/Apache-Gallery/Apache-Gallery-0.9.1.ebuild,v 1.2 2005/08/08 21:54:47 rl03 Exp $

inherit depend.apache perl-module webapp

DESCRIPTION="Apache gallery for mod_perl"
SRC_URI="http://apachegallery.dk/download/${P}.tar.gz"
HOMEPAGE="http://apachegallery.dk/"

LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="apache2"

DEPEND="${DEPEND}
	=dev-lang/perl-5*
	>=media-libs/imlib2-1.0.6-r1
	>=dev-perl/ImageInfo-1.04-r2
	>=dev-perl/ImageSize-2.99-r1
	dev-perl/Image-Imlib2
	>=perl-core/CGI-2.93
	>=dev-perl/CGI-FastTemplate-1.09
	>=dev-perl/Parse-RecDescent-1.80-r3
	dev-perl/URI
	dev-perl/text-template
	>=dev-perl/Inline-0.43-r1
	virtual/x11
	!apache2? ( >=net-www/apache-1.3.26-r2
		=www-apache/libapreq-1* )
	apache2? ( >=net-www/apache-2.0.43-r1
		=www-apache/libapreq2-2* )"

src_install() {
	webapp_src_preinst
	mydoc="INSTALL"

	perl-module_src_install

	insinto ${MY_ICONSDIR}/gallery
	doins htdocs/*.png

	dodir ${MY_HOSTROOTDIR}/${PN}/templates/default
	dodir ${MY_HOSTROOTDIR}/${PN}/templates/new

	insinto ${MY_HOSTROOTDIR}/${PN}/templates/default
	doins templates/default/*
	insinto ${MY_HOSTROOTDIR}/${PN}/templates/new
	doins templates/new/*

	if use apache2; then
		insinto ${APACHE2_VHOSTDIR}
		doins ${FILESDIR}/76_apache2-gallery.conf
	else
		insinto ${APACHE1_VHOSTDIR}
		doins ${FILESDIR}/76_apache1-gallery.conf
	fi

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
