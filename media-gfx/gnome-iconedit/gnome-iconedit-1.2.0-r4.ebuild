# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnome-iconedit/gnome-iconedit-1.2.0-r4.ebuild,v 1.3 2002/07/11 06:30:27 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Edits icons, what more can you say?"
SRC_URI="http://210.77.60.218/ftp/ftp.debian.org/pool/main/g/gnome-iconedit/gnome-iconedit_${PV}.orig.tar.gz"
HOMEPAGE="www.advogato.org/proj/GNOME-Iconedit/"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	=x11-libs/gtk+-1.2*
	>=media-libs/gdk-pixbuf-0.11.0-r1
	media-libs/libpng
	gnome-base/ORBit"
# Gnome-Print support is broken
#	>=gnome-base/gnome-print-0.30
# Bonobo support is broken
#	bonobo? ( gnome-base/bonobo )"



src_unpack() {

	unpack ${A}

	# Fix some compile / #include errors
	cd ${S}
	patch -p1 <${FILESDIR}/gnome-iconedit.diff || die

	# Update the Makefiles.
	export WANT_AUTOMAKE_1_4=1
	export WANT_AUTOCONF_2_1=1
	automake --add-missing
	autoconf
}

src_compile() {

	local myconf
	use nls || myconf="--disable-nls"
	
	CFLAGS="${CFLAGS} `gnome-config --cflags print`"	

	./configure --host=${CHOST} 					\
		--prefix=/usr					\
		--mandir=/usr/share/man				\
		--infodir=/usr/share/info				\
		--with-sysconfdir=/etc				\
		--without-gnome-print				\
		${myconf} || die

	emake || die
}

src_install() {

	make prefix=${D}/usr						\
		mandir=${D}/usr/share/man					\
		infodir=${D}/usr/share/info				\
		sysconfdir=${D}/etc install || die

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
