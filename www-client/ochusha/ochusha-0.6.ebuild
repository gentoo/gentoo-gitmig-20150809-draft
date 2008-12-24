# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/ochusha/ochusha-0.6.ebuild,v 1.1 2008/12/24 00:39:43 matsuu Exp $

inherit eutils

IUSE="nls nls ssl static"

DESCRIPTION="Ochusha - 2ch viewer for GTK+"
HOMEPAGE="http://ochusha.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/36733/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"

RDEPEND=">=x11-libs/gtk+-2.6
	>=dev-libs/glib-2.6
	>=dev-libs/libxml2-2.6
	>=dev-db/sqlite-3
	sys-libs/zlib
	dev-libs/oniguruma
	nls? ( virtual/libintl )
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable nls) \
		$(use_with ssl) \
		$(use_with ssl ca-cert-path /etc/ssl/certs) \
		$(use_enable static) \
		--with-external-oniguruma || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	domenu ochusha/ochusha.desktop
	#doicon ochusha/ochusha48.png

	dodoc ACKNOWLEDGEMENT AUTHORS BUGS ChangeLog NEWS README TODO
}
