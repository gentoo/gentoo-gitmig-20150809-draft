# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-core/gnome-core-1.4.0.4.ebuild,v 1.8 2001/08/31 22:54:33 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-core"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=gnome-base/control-center-1.2.4 >=gnome-base/libglade-0.16-r1"

DEPEND="${RDEPEND}
        nls? ( sys-devel/gettext )
	>=gnome-base/gnome-libs-1.2.13
        >=sys-apps/tcp-wrappers-7.6
        >=gnome-base/scrollkeeper-0.2
	>=dev-util/xml-i18n-tools-0.8.4"

src_compile() {
	local myconf
	local myldflags

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	if [ "`use gtkhtml`" ]
	then
		# does not work !
		#myconf="${myconf} --enable-gtkhtml-help"
	fi

	if [ "`use kde`" ]
	then
		myconf="${myconf} --with-kde-datadir=/opt/kde2/share"
	fi

	./configure --host=${CHOST} --mandir=/opt/gnome/man  		\
		    --prefix=/opt/gnome  --sysconfdir=/etc/opt/gnome 	\
		    ${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS
}
