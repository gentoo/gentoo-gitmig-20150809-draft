# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/guppi/guppi-0.40.3-r2.ebuild,v 1.7 2004/01/09 23:23:01 agriffis Exp $

IUSE="python nls readline"

MY_P=${P/guppi/Guppi}
S=${WORKDIR}/${MY_P}
DESCRIPTION="GNOME Plotting Tool"
# ftp.gnome.org is slooow in updating ;/
SRC_URI="ftp://ftp.yggdrasil.com/mirrors/site/ftp.gnome.org/pub/GNOME/stable/sources/Guppi/${MY_P}.tar.bz2
	ftp://ftp.gnome.org/pub/GNOME/stable/sources/Guppi/${MY_P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/guppi/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"


RDEPEND="=x11-libs/gtk+-1.2*
	 >=gnome-base/gnome-libs-1.4.1.2
	 >=gnome-base/oaf-0.6.7
	 <gnome-base/libglade-0.90
	 >=gnome-base/gnome-print-0.31
	 >=media-libs/gdk-pixbuf-0.13
	 >=dev-util/guile-1.4
	 >=gnome-base/bonobo-1.0.17
	 <gnome-extra/gal-1.99"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext
		>=dev-util/intltool-0.11 )
	python? ( >=dev-lang/python-2.0 )"

src_compile() {

	local myconf

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

	# We need this for gnumeric support.  Note that you do
	# not need gnumeric installed for this to work.
	myconf="${myconf} --enable-gnumeric"

# to compile with guile-1.5
#	CFLAGS="${CFLAGS} -DGUPPI_USING_NEWER_GUILE `gnome-config --cflags libglade`"

	./configure	--host=${CHOST} \
			--prefix=/usr \
			--mandir=/usr/share/man \
			--infodir=/usr/share/info \
			--sysconfdir=/etc \
			--localstatedir=/var/lib \
			--with-bonobo \
			${myconf} || die

	# The python 'generate' module opens some files in rw mode for some
	# unknown reason.
	addwrite "/usr/lib/python2.0/"
	addwrite "/usr/lib/python2.1/"
	addwrite "/usr/lib/python2.2/"

	emake || die
}

src_install() {
	make	prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
