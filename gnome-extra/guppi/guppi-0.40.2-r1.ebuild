# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/guppi/guppi-0.40.2-r1.ebuild,v 1.2 2002/01/08 19:10:48 azarah Exp $

PN=Guppi
P=${PN}-${PV}
S=${WORKDIR}/${P}
DESCRIPTION="GNOME Plottin Tool"
# ftp.gnome.org is slooow in updating ;/
SRC_URI="ftp://ftp.yggdrasil.com/mirrors/site/ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.bz2
	ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/guppi/"

RDEPEND=">=x11-libs/gtk+-1.2.10-r3
	 >=gnome-base/gnome-libs-1.4.1.2
	 >=gnome-base/oaf-0.6.7
	 >=gnome-base/libglade-0.17
	 >=gnome-base/gnome-print-0.31
	 >=media-libs/gdk-pixbuf-0.13
	 >=dev-util/guile-1.5
	 >=gnome-base/bonobo-1.0.17"
# Seems that bonobo *is* needed ....

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
        >=dev-util/intltool-0.11
	python? ( >=dev-lang/python-2.0 )"


src_compile() {

	local myconf

	if [ "`use bonobo`" ]
	then
		myconf="--enable-bonobo"
	else
		myconf="--disable-bonobo"
	fi

	if [ "`use python`" ]
	then
		myconf="${myconf} --enable-python"
	else
		myconf="${myconf} --disable-python"
	fi

	if [ -z "`use nls`" ] ; then
		myconf="${myconf} --disable-nls"
	fi

	if [ -z "`use readline`" ] ; then
		myconf="${myconf} --disable-guile-readline"
	fi

	CFLAGS="${CFLAGS} -DGUPPI_USING_NEWER_GUILE `gnome-config --cflags libglade`"

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    ${myconf} || die

	# The python 'generate' module opens some files in rw mode for some
	# unknown reason.
	SANDBOX_WRITE="${SANDBOX_WRITE}:/usr/lib/python2.1/"

	make || die # Doesn't work with -j 4 (hallski)
}

src_install() {

	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
