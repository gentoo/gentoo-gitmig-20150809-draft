# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-ftp/deadftp/deadftp-0.1.3.ebuild,v 1.1 2002/07/09 10:10:34 stroke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gnome based FTP Client"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/deadftp/${P}.tar.bz2"
HOMEPAGE="http://deadftp.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="*"

DEPEND="=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	( >=gnome-base/libglade-0.17
	 <gnome-base/libglade-2.0.0 )
	>=media-libs/gdk-pixbuf-0.18.0
	>=gnome-base/ORBit-0.5.16
	>=gnome-base/gnome-libs-1.4.1.7"

RDEPEND="${DEPEND}
	nls? ( >=sys-devel/gettext-0.10.40 >=dev-util/intltool-0.11 )"


src_compile() {
	local myconf
	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man ${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/usr mandir=${D}/usr/share/man install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
