# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aria/aria-0.10.0.ebuild,v 1.12 2004/07/15 02:34:04 agriffis Exp $

IUSE="nls"

DESCRIPTION="Aria is a download manager with a GTK+ GUI, it downloads files from Internet via HTTP/HTTPS or FTP."
HOMEPAGE="http://aria.rednoah.com"
SRC_URI="http://aria.rednoah.com/storage/sources/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

RDEPEND="=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	>=sys-devel/gettext-0.10.35"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext
		>=dev-util/intltool-0.11 )"

src_compile() {
	econf \
		`use_enable nls` || die
	emake || die
}

src_install () {
	einstall || die

	dodoc AUTHORS README* NEWS ChangeLog TODO COPYING
}
