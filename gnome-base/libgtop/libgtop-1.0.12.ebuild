# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgtop/libgtop-1.0.12.ebuild,v 1.6 2001/08/31 22:13:44 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libgtop"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"

HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=sys-devel/bc-1.06
	 >=sys-libs/readline-4.1
         >=gnome-base/gnome-libs-1.2.12"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext ) 
	sys-devel/perl"

src_compile() {
	local myconf

	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} --prefix=/opt/gnome 		\
	            --sysconfdir=/etc/opt/gnome \			\
		    --mandir=/opt/gnome/man				\
		    --infodir=/opt/gnome/share/info ${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/opt/gnome install || die

	dodoc ABOUT-NLS AUTHORS COPYING* ChangeLog INSTALL LIBGTOP* README NEWS
	dodoc RELNOTES*
	doinfo doc/libgtop.info
}
