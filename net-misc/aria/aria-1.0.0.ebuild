# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aria/aria-1.0.0.ebuild,v 1.2 2004/02/09 06:39:48 jhhudso Exp $

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

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/aria-1.0.0-xgettext-gentoo.diff
	epatch ${FILESDIR}/aria-1.0.0-savefiles-gentoo.diff
}

src_compile() {
	econf `use_enable nls` || die "econf failed"

	# This fixes an infinite loop bug
	touch Makefile

	emake || die "emake failed"
}

src_install() {
	einstall || die

	dodoc AUTHORS README* NEWS ChangeLog TODO COPYING
	touch ${D}/usr/share/aria/ftp_proxy.aria
	touch ${D}/usr/share/aria/gui.aria
	touch ${D}/usr/share/aria/history.aria
	touch ${D}/usr/share/aria/http_proxy.aria
}
