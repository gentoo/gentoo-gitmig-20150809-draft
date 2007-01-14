# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_dav/mod_dav-1.0.3-r3.ebuild,v 1.5 2007/01/14 16:31:52 chtekk Exp $

inherit eutils autotools apache-module

MY_V=${PV}-1.3.6

DESCRIPTION="Apache module for Distributed Authoring and Versioning."
HOMEPAGE="http://www.webdav.org/mod_dav/"
SRC_URI="http://www.webdav.org/mod_dav/${PN}-${MY_V}.tar.gz"

KEYWORDS="~amd64 ppc sparc x86"
LICENSE="as-is"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}-${MY_V}"

DOCFILES="LICENSE.html README CHANGES INSTALL"

APACHE1_MOD_FILE="libdav.so"
APACHE1_MOD_CONF="10_${PN}"
APACHE1_MOD_DEFINE="DAV"

need_apache1

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-shared-expat.patch"
	epatch "${FILESDIR}/${PN}_fs_lock.patch"
	eautoconf
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

pkg_postinst() {
	install -m0750 -o apache -g apache -d "${ROOT}"/var/lock/mod_dav
	apache1_pkg_postinst
}
