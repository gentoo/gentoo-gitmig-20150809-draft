# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/kasablanca/kasablanca-0.3.1.ebuild,v 1.1 2004/04/21 02:58:31 dragonheart Exp $

inherit kde
need-kde 3.1

DESCRIPTION="a graphical ftp client for kde. among its features are support for ssl/tls encryption (both commands and data using auth tls, not sftp), fxp (direct ftp to ftp transfer) bookmarks, and queues."
HOMEPAGE="http://kasablanca.berlios.de/"
SRC_URI="http://download.berlios.de/kasablanca/kasablanca-${PV}.tar.gz"
LICENSE="GPL-2"
RESTRICT="nomirror"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="${DEPEND}
	sys-apps/gawk
	sys-apps/sed
	sys-devel/libtool
	>=sys-devel/automake-1.6
	sys-devel/autoconf
	sys-devel/gettext
	x11-libs/qt
	dev-libs/openssl"


RDEPEND="${RDEPEND}
	sys-devel/gettext
	x11-libs/qt
	dev-libs/openssl"




src_install() {
	kde_src_install all
	mv ${D}/usr/share/doc/HTML ${D}/usr/share/doc/${PF}
}
