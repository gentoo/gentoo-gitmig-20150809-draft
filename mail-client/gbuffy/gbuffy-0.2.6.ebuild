# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/gbuffy/gbuffy-0.2.6.ebuild,v 1.2 2004/11/03 10:05:24 mr_bones_ Exp $

inherit eutils

DESCRIPTION="A multi-mailbox biff-like monitor"
HOMEPAGE="http://www.fiction.net/blong/programs/gbuffy/"
SRC_URI="http://www.fiction.net/blong/programs/${PN}/${P}/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ia64"

IUSE="gnome ssl"

DEPEND="x11-libs/libPropList
	media-libs/compface
	>=x11-libs/gtk+-1.1.11
	gnome? ( >=gnome-base/gnome-panel-2.4.0-r1 )
	ssl? ( dev-libs/openssl )"

src_compile() {
	if use gnome; then
		econf --enable-applet || die
		emake || die
		mv gbuffy gbuffy_applet
		make clean
	fi
	econf --disable-applet || die
	emake || die
}

src_install() {
	einstall || die
	dodoc ChangeLog CHANGES GBuffy LICENSE README ToDo
	doman gbuffy.1
	use gnome && dobin gbuffy_applet
}
