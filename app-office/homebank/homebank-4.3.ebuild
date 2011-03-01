# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/homebank/homebank-4.3.ebuild,v 1.2 2011/03/01 00:58:37 calchan Exp $

EAPI="2"

inherit fdo-mime

DESCRIPTION="Free, easy, personal accounting for everyone"
HOMEPAGE="http://homebank.free.fr/index.php"
SRC_URI="http://homebank.free.fr/public/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="ofx"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=x11-libs/gtk+-2.14
	>=dev-libs/glib-2.17
	sys-libs/zlib
	ofx? ( >=dev-libs/libofx-0.7 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.40.5"
RDEPEND="${RDEPEND}
	gnome-base/librsvg"

S="${WORKDIR}/${P/_/}"

src_prepare() {
	sed -i -e 's/true/TRUE/' src/import.c || die "sed failed"
	echo -e "src/da_encoding.c\nsrc/hb_transaction.c" >> po/POTFILES.in || die "echo failed"
}

src_configure() {
	econf $(use_with ofx)
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"
	dodoc AUTHORS ChangeLog README
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
