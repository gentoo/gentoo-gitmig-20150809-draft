# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aria/aria-1.0.0.ebuild,v 1.1 2003/05/15 20:47:36 jhhudso Exp $

DESCRIPTION="Aria is a download manager with a GTK+ GUI, it downloads files from the Internet via HTTP/HTTPS or FTP."
HOMEPAGE="http://aria.rednoah.com"
SRC_URI="http://aria.rednoah.com/storage/sources/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext dev-util/intltool )
	dev-libs/glib
	x11-libs/gtk+"

S=${WORKDIR}/${P}

src_install() {
	einstall || die

	dodoc AUTHORS README* NEWS ChangeLog TODO COPYING
}
