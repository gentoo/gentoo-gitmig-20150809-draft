# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp-print/gimp-print-4.2.1.ebuild,v 1.4 2002/07/23 04:33:46 seemant Exp $

inherit libtool

MY_P=${P}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Gimp Plugin and Ghostscript driver for Gimp"
SRC_URI="mirror://sourceforge/gimp-print/${MY_P}.tar.gz"
HOMEPAGE="http://gimp-print.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-gfx/gimp-1.2.1
	doc? ( app-text/texi2html )
	gtk? ( =x11-libs/gtk+-1.2* )
	cups? ( net-print/cups )"

RDEPEND="virtual/glibc"

src_compile() {
	
	elibtoolize
	aclocal

	local myconf

	use cups \
		&& myconf="${myconf} --with-cups" \
		|| myconf="${myconf} --without-cups"
	
	use nls || myconf="${myconf} --disable-nls"
	
	econf \
		--sysconfdir=/etc/gimp/1.2/ \
		--with-gimp-exec-prefix=/usr \
		${myconf} || die

	cp src/gimp/Makefile src/gimp/Makefile.orig
	sed -e 's:--install-admin-bin:--install-bin:g' \
		src/gimp/Makefile.orig >src/gimp/Makefile
	
	emake || die
}

src_install() {
	
	dodir /usr/lib/gimp/1.2/.gimp-1.2/plug-ins
	
	make prefix=${D}/usr \
		bindir=${D}/usr/bin \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		sysconfdir=${D}/etc/gimp/1.2 \
		libdir=${D}/usr/lib \
		datadir=${D}/usr/share \
		cups_conf_serverbin=${D}/usr/lib/cups \
		cups_conf_datadir=${D}/usr/share/cups \
		cups_conf_serverroot=${D}/etc/cups \
		HOME=${D}/usr/lib/gimp/1.2 \
		install || die

	# NOTE: this build use gimptool to install the plugin, so
	# if we dont do it this way, it will install to / no
	# matter what.
	#
	# NOTE to whoever commented this: Please DO NOT!
	mv ${D}/usr/lib/gimp/1.2/.gimp-1.2/plug-ins/ \
		${D}/usr/lib/gimp/1.2/
	rm -rf ${D}/usr/lib/gimp/1.2/.gimp-1.2/
	     
	dodoc AUTHORS ChangeLog COPYING NEWS README*
	dohtml -r doc
}
