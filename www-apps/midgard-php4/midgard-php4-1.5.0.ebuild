# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/midgard-php4/midgard-php4-1.5.0.ebuild,v 1.1 2004/09/22 10:50:57 rl03 Exp $

DESCRIPTION="PHP module for the Midgard framework"
HOMEPAGE="http://www.midgard-project.org/"
SRC_URI="http://www.midgard-project.org/midcom-serveattachmentguid-d3c7034481033f46e330054b812bad28/${P}.tar.bz2"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=www-apps/midgard-lib-${PV}
	>=virtual/php-4.0.6 <virtual/php-5
"

pkg_setup() {
	ewarn "PHP needs to be compiled with MySQL and XML support"
}

src_compile() {
	phpize || die "phpize failed"
	econf
	# set INSTALL_ROOT to respect sandbox
	sed "1iINSTALL_ROOT=${D}" -i Makefile
	emake
}

src_install() {
	dodoc ChangeLog INSTALL README.session
	einstall || die "install failed"
}

pkg_postinst() {
	einfo "Edit your php.ini to add:"
	einfo "extension=midgard.so"
	einfo "and make sure that extension_dir at least contains the output of"
	einfo "php-config --extension-dir"
	einfo "Ensure that you have file_uploads and short_open_tags turned on"
	einfo "Then restart Apache"
}
