# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/parcellite/parcellite-0.9.ebuild,v 1.1 2008/12/01 19:31:55 ssuominen Exp $

inherit fdo-mime

DESCRIPTION="A lightweight GTK+ based clipboard manager."
HOMEPAGE="http://parcellite.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.10
	>=dev-libs/glib-2.14"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext
		dev-util/intltool )"

src_compile() {
	econf --disable-dependency-tracking $(use_enable nls)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS README
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
