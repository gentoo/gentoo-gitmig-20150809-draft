# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_dav/mod_dav-1.0.3-r3.ebuild,v 1.1 2005/01/08 21:18:40 hollow Exp $

inherit eutils apache-module

MY_V=${PV}-1.3.6

DESCRIPTION="Apache module for Distributed Authoring and Versioning"
HOMEPAGE="http://www.webdav.org/mod_dav/"
SRC_URI="http://www.webdav.org/mod_dav/${PN}-${MY_V}.tar.gz"

KEYWORDS="~x86 ~sparc ~ppc ~amd64"
DEPEND=""
LICENSE="as-is"
SLOT="0"
IUSE=""

S=${WORKDIR}/${PN}-${MY_V}

DOCFILES="LICENSE.html README CHANGES INSTALL"

APACHE1_MOD_FILE="libdav.so"
APACHE1_MOD_CONF="10_${PN}"
APACHE1_MOD_DEFINE="DAV"

need_apache1

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	epatch ${FILESDIR}/${PN}-shared-expat.patch || die
	epatch ${FILESDIR}/mod_dav_fs_lock.patch || die
	autoconf || die
}

src_compile() {
	./configure --host=${CHOST} || die
	emake || die "compile problem"
}

pkg_postinst() {
	# empty lock dir
	install -m0750 -o apache -g apache -d ${ROOT}/var/lock/mod_dav
	apache1_pkg_postinst
}
