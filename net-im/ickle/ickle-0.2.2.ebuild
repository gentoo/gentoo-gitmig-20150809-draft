# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/ickle/ickle-0.2.2.ebuild,v 1.1 2002/01/12 13:58:42 verwilst Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gnome ICQ Client, which uses the ICQ2000 protocol"
SRC_URI="http://prdownloads.sourceforge.net/ickle/${P}.tar.gz"
HOMEPAGE="http://ickle.sourceforge.net"

DEPEND="virtual/glibc
	>=x11-libs/gtkmm-1.2.8
	>=dev-libs/libsigc++-1.0.4
	>=gnome-base/gnome-core-1.4.0
	>=gnome-base/gnome-libs-1.4.0"

src_compile() {

	./configure --host=${CHOST} --prefix=/usr || die				
	emake || die

}

src_install() {
	make prefix=${D}/usr install || die
}

