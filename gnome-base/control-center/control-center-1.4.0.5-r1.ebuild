# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/control-center/control-center-1.4.0.5-r1.ebuild,v 1.24 2004/11/05 23:01:07 corsair Exp $

inherit gnome.org eutils

IUSE="nls"

DESCRIPTION="The GNOME control-center"
HOMEPAGE="http://www.gnome.org/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 mips ~ppc64"

RDEPEND="<gnome-base/gnome-vfs-1.9.0
	>=media-libs/gdk-pixbuf-0.11.0-r1"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=dev-util/intltool-0.11"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-cflags.patch
}

src_compile() {
	local myconf

	if ! use nls
	then
		myconf="--disable-nls"
	fi

	# Fix build agains gdk-pixbuf-0.12 and later
	#	CFLAGS="${CFLAGS} `gdk-pixbuf-config --cflags`"
	# Not needed anymore? uncomment if this bugs.

	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --mandir=/usr/share/man \
		    --sysconfdir=/etc \
		    --localstatedir=/var/lib \
		    ${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib	\
		install || die
	dodoc AUTHORS COPYING* ChangeLog README NEWS
}
