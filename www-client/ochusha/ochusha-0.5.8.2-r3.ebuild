# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/ochusha/ochusha-0.5.8.2-r3.ebuild,v 1.7 2009/01/04 23:21:14 ulm Exp $

inherit flag-o-matic eutils

IUSE="nls ssl"

DESCRIPTION="Ochusha - 2ch viewer for GTK+"
HOMEPAGE="http://ochusha.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/16560/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"

RDEPEND="x11-libs/libXft
	>=x11-libs/gtk+-2.2.4
	>=dev-libs/glib-2.2.3
	>=dev-libs/libxml2-2.5.0
	sys-libs/zlib
	nls? ( virtual/libintl )
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.diff
	epatch "${FILESDIR}"/${P}-glib-2.10.diff
	epatch "${FILESDIR}"/${P}-glibc2.diff
	epatch "${FILESDIR}"/${P}-type-punning.diff
	epatch "${FILESDIR}"/${P}-gtk-2.12.diff
}

src_compile() {
	econf $(use_enable nls) \
		$(use_with ssl) \
		--enable-regex \
		--disable-shared \
		--enable-static \
		--with-included-oniguruma || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	rm "${D}"/usr/share/ochusha/ochusha.desktop

	insinto /usr/share/applications
	doins "${S}/gtk2/ochusha.desktop"
	sed -i -e 's:Icon=.*:Icon=ochusha:' "${D}"/usr/share/applications/ochusha.desktop

	insinto /usr/share/icons/hicolor/48x48/apps
	newins "${S}/gtk2/ochusha48.png" ochusha.png

	dodoc ACKNOWLEDGEMENT AUTHORS BUGS \
		ChangeLog INSTALL* NEWS README TODO
}
