# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/Apache-Gallery/Apache-Gallery-1.0_rc3.ebuild,v 1.5 2007/01/20 15:19:11 mcummings Exp $

inherit depend.apache perl-module webapp

WEBAPP_MANUAL_SLOT="yes"
SLOT="0"
MY_P=${P/_rc/RC}
DESCRIPTION="Apache gallery for mod_perl"
SRC_URI="http://apachegallery.dk/download/${MY_P}.tar.gz"
HOMEPAGE="http://apachegallery.dk/"

LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="apache2"

S=${WORKDIR}/${MY_P}

DEPEND="${DEPEND}
	=dev-lang/perl-5*
	!apache2? ( >=net-www/apache-1.3.26-r2
		=www-misc/libapreq-1* )
	apache2? ( >=net-www/apache-2.0.43-r1
		=www-misc/libapreq2-2* )
	>=media-libs/imlib2-1.0.6-r1
	dev-perl/URI
	>=dev-perl/ImageInfo-1.04-r2
	>=dev-perl/ImageSize-2.99-r1
	dev-perl/text-template
	>=virtual/perl-CGI-3.08
	dev-perl/Image-Imlib2
"

src_install() {
	webapp_src_preinst
	dodoc Changes INSTALL README TODO UPGRADE

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
