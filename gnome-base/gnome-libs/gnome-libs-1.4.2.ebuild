# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-libs/gnome-libs-1.4.2.ebuild,v 1.8 2003/07/04 05:32:51 gmsoft Exp $

IUSE="doc nls kde"


inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="GNOME Core Libraries"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/sources/${PN}/1.4/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"
KEYWORDS="x86 alpha hppa"
#  ppc sparc sparc64"

DEPEND=">=media-libs/imlib-1.9.10
		>=media-sound/esound-0.2.23
		>=gnome-base/ORBit-0.5.12
		=x11-libs/gtk+-1.2*
		<sys-libs/db-2
		doc? ( app-text/docbook-sgml 
		       dev-util/gtk-doc )"

RDEPEND="nls? ( >=sys-devel/gettext-0.10.40 >=dev-util/intltool-0.11 )"

SLOT="1"

src_compile() {                           
	CFLAGS="$CFLAGS -I/usr/include/db1"

	local myconf

	use nls || myconf="${myconf} --disable-nls"
	use kde && myconf="${myconf} --with-kde-datadir=/usr/share"
	use doc || myconf="${myconf} --disable-gtk-doc"

	# libtoolize
	elibtoolize 

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		--enable-prefer-db1 \
		${myconf} || die

	emake || die

	#do the docs (maby add a use variable or put in seperate
	#ebuild since it is mostly developer docs?)
	if [ -n "`use doc`" ]
	then
		cd ${S}/devel-docs
		emake || die
		cd ${S}
	fi
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		docdir=${D}/usr/share/doc/${P} \
		HTML_DIR=${D}/usr/share/gnome/html \
		install || die

	rm ${D}/usr/share/gtkrc*

	dodoc AUTHORS COPYING* ChangeLog README NEWS HACKING
}

