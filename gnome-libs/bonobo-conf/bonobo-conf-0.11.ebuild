# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-libs/bonobo-conf/bonobo-conf-0.11.ebuild,v 1.2 2001/08/31 23:32:48 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Bonobo Configuration System"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=dev-libs/glib-1.2.0
	 >=x11-libs/gtk+-1.2.0
	 >=gnome-base/bonobo-1.0
	 >=gnome-base/oaf-0.6.2"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=dev-util/xml-i18n-tools-0.8.4"

src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} 					\
		    --prefix=/opt/gnome 				\
		    --sysconfdir=/etc/opt/gnome				\
		    --mandir=/opt/gnome/man				\
		    --disable-more-warnings $myconf || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}
