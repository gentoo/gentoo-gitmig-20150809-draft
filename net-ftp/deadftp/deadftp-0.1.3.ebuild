# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/deadftp/deadftp-0.1.3.ebuild,v 1.12 2004/07/14 23:54:50 agriffis Exp $

IUSE="nls"

DESCRIPTION="Gnome based FTP Client"
SRC_URI="mirror://sourceforge/deadftp/${P}.tar.bz2"
HOMEPAGE="http://deadftp.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	=gnome-base/libglade-0.17*
	>=media-libs/gdk-pixbuf-0.18.0
	>=gnome-base/ORBit-0.5.16
	>=gnome-base/gnome-libs-1.4.1.7"

RDEPEND="nls? ( >=sys-devel/gettext-0.10.40
	>=dev-util/intltool-0.11 )"


src_compile() {
	local myconf
	use nls || myconf="--disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
