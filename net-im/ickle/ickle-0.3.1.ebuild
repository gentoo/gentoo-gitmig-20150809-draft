# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer: Spider <spider@gentoo.org>, Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/ickle/ickle-0.3.1.ebuild,v 1.2 2002/05/23 06:50:15 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="ICQ 200x compatible ICQ client. limited featureset."
SRC_URI="http://prdownloads.sourceforge.net/ickle/${P}.tar.gz"
HOMEPAGE="http://ickle.sf.net"
SLOT="0"


DEPEND="=x11-libs/gtk+-1.2*
		>=x11-libs/gtkmm-1.2.5
		>=dev-libs/libsigc++-1.0.4
		>=sys-libs/lib-compat-1.0
		=net-libs/libicq2000-0.3.1
		spell? ( app-text/ispell )
		gnome? ( >= gnome-base/gnome-applets-1.4.0 
			 >= gnome-base/gnome-libs-1.4.1 )"

src_compile() {
	local myflags
	myflags=""
	if [ -z "`use gnome`" ]
	then
		myflags="--without-gnome"
	else
		myflags="--with-gnome"
	fi
	./configure ${myflags} \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--localstatedir=/var/lib \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die

}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS  COPYING ChangeLog  INSTALL NEWS README THANKS TODO 
}
