# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit/gedit-0.9.6-r1.ebuild,v 1.11 2003/07/01 21:47:40 aliz Exp $

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="Gnome Text Editor"
SRC_URI="mirror://gnome//sources/gedit/${PV/.6}/${P}.tar.gz"
HOMEPAGE="http://gedit.sourceforge.net/"
SLOT="O"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

RDEPEND=" <gnome-base/libglade-2
	 >=gnome-base/gnome-print-0.30
	 =gnome-base/gnome-vfs-1*"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"


src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	CFLAGS="${CFLAGS} `gnome-config --cflags libglade vfs`"

	./configure --host=${CHOST} \
		    --prefix=/usr \
		    ${myconf} || die
	
	emake || die
}

src_install() {
		make prefix=${D}/usr install || die

	dodoc AUTHORS BUGS COPYING ChangeLog FAQ NEWS README* THANKS TODO
}
