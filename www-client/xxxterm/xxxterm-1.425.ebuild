# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/xxxterm/xxxterm-1.425.ebuild,v 1.1 2011/07/23 02:37:01 rafaelmartins Exp $

EAPI="4"

inherit eutils fdo-mime toolchain-funcs

DESCRIPTION="A minimalist web browser with sophisticated security features designed-in"
HOMEPAGE="http://opensource.conformal.com/wiki/xxxterm"
SRC_URI="http://opensource.conformal.com/snapshots/${PN}/${P}.tgz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/gtk+
	net-libs/webkit-gtk
	net-libs/libsoup
	net-libs/gnutls
	dev-libs/libbsd"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/linux"

src_prepare() {
	sed -i \
		's/-Wall -ggdb //' \
		Makefile || die 'sed Makefile failed.'
	sed -i \
		-e 's#https://www\.cyphertite\.com#http://www.gentoo.org/#' \
		-e "s#/usr/local#/usr#" \
		../xxxterm.c || die 'sed ../xxxterm.c failed.'
	sed -i \
		"s#Icon=#Icon=/usr/share/${PN}/#" \
		../xxxterm.desktop || die 'sed ../xxxterm.desktop failed.'
}

src_compile() {
	emake \
		CC="$(tc-getCC)"
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}"
}

src_install() {
	einstall \
		DESTDIR="${D}" \
		PREFIX=/usr

	insinto /usr/share/${PN}
	doins ../*.png ../style.css
	insinto /usr/share/applications
	doins ../xxxterm.desktop
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
