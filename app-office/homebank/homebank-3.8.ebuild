# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/homebank/homebank-3.8.ebuild,v 1.1 2008/04/23 08:22:37 calchan Exp $

inherit autotools fdo-mime

DESCRIPTION="Free, easy, personal accounting for everyone"
HOMEPAGE="http://homebank.free.fr/index.php"
SRC_URI="http://homebank.free.fr/public/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="ofx"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=x11-libs/gtk+-2.0
	ofx? ( >=dev-libs/libofx-0.7 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
RDEPEND="${RDEPEND}
	gnome-base/librsvg"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e 's/-Werror//' configure.ac \
		-e 's/LDFLAGS="${LDFLAGS} -lofx"/LIBS="${LIBS} -lofx"/' \
		configure.ac || die "sed failed"

	eautoconf
}

src_compile() {
	econf $(use_with ofx) || die "Configuration failed"
	emake || die "Compilation failed"
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
