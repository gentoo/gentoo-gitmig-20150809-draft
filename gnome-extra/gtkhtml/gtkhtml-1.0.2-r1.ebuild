# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gtkhtml/gtkhtml-1.0.2-r1.ebuild,v 1.3 2002/07/25 04:04:08 spider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="gtkhtml"
SRC_URI="ftp://ftp.ximian.com/pub/source/evolution/${P}.tar.gz
	 ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${P}.tar.gz"

HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 ppc"
SLOT="0"


RDEPEND=">=gnome-extra/gal-0.19
	>=gnome-base/control-center-1.4.0.1-r1
	>=gnome-base/libghttp-1.0.9-r1
	>=dev-libs/libunicode-0.4-r1
	>=gnome-base/gnome-print-0.34
	>=gnome-base/bonobo-1.0.18
	gnome? ( >=gnome-base/gconf-1.0.7-r2 )
	nls? ( sys-devel/gettext
	>=dev-util/intltool-0.11 )"

DEPEND="${RDEPEND}"

src_compile() {

	local myconf

	use nls || myconf="${myconf} --disable-nls"

	# Evo users need to have bonobo support
	#use bonobo \
	#	&& myconf="${myconf} --with-bonobo"	\
	#	|| myconf="${myconf} --without-bonobo"

	use gnome	\
		&& myconf="${myconf} --with-gconf"	\
		|| myconf="${myconf} --without-gconf"

  	./configure 	\
		--host=${CHOST} 				\
		--prefix=/usr					\
		--sysconfdir=/etc					\
		--localstatedir=/var/lib				\
		${myconf} || die

  	emake || die "Package building failed."
}

src_install() {

	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	# Fix the double entry in Control Center
	rm ${D}/usr/share/control-center/capplets/gtkhtml-properties.desktop

  	dodoc AUTHORS COPYING* ChangeLog README
  	dodoc NEWS TODO
}
