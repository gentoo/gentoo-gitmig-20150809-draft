# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gdm/gdm-2.2.3.2-r4.ebuild,v 1.1 2001/10/07 11:51:57 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNOME Display Manager"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gdm/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=sys-libs/pam-0.72
	>=sys-apps/tcp-wrappers-7.6
	>=gnome-base/gnome-libs-1.4.1.2-r1
	>=gnome-base/libglade-0.17-r1
	>=media-libs/gdk-pixbuf-0.11.0-r1"

src_unpack() {
	unpack ${A}

	cd ${S}/daemon
	cp gdm.h gdm.h.orig
	sed -e "s:/usr/bin/X11:/usr/X11R6/bin:g" gdm.h.orig > gdm.h
	rm gdm.h.orig

	cd ${S}/config
	cp gdm.conf.in gdm.conf.in.orig
	sed -e "s:/usr/bin/X11:/usr/X11R6/bin:g" gdm.conf.in.orig > gdm.conf.in
	rm gdm.conf.in.orig
}

src_compile() {                           
	CFLAGS="${CFLAGS} `gnome-config --cflags libglade`"

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc/X11				\
		    --localstatedir=/var/lib				\
		    --with-pam-prefix=/etc || die

	emake || die
}

src_install() {                               
	make DESTDIR=${D}						\
	     sysconfdir=${D}/etc/X11					\
	     localstatedir=${D}/var/lib install || die

	rm -rf ${D}/etc/X11/pam.d

	# log
	dodir /var
	dodir /var/lib
	dodir /var/lib/gdm
	chown gdm:gdm ${D}/var/lib/gdm
	chmod 750 ${D}/var/lib/gdm
  
	# pam startup
	dodir /etc/pam.d
	cd ${FILESDIR}/2.2.3/pam.d
	insinto /etc/pam.d
	doins gdm

	# gnomerc
	dodir /etc/X11/gdm
	cd ${FILESDIR}/2.2.3
	exeinto /etc/X11/gdm
	doexe gnomerc

	cd ${D}/etc/X11/gdm
	for i in Init/Default PostSession/Default PreSession/Default gdm.conf
	do
		cp $i $i.orig
		sed -e "s:/usr/bin/X11:/usr/X11R6/bin:g" $i.orig > $i
		rm $i.orig
	done

	cd ${D}/etc/X11/gdm
	cp gdm.conf gdm.conf.orig
	
	sed -e "s:0=/usr/X11R6/bin/X:0=/usr/X11R6/bin/X -dpi 100 -nolisten tcp dpms vt7:g" \
	    -e "s:GtkRC=/opt/gnome/share/themes/Default/gtk/gtkrc:GtkRC=/usr/X11R6/share/themes/gtk/gtkrc:g" \
	    -e "s:BackgroundColor=#007777:BackgroundColor=#2a3f5b:g" \
	    -e "s:TitleBar=true:TitleBar=false:g" \
		gdm.conf.orig > gdm.conf

	rm gdm.conf.orig

	cd ${S}
	dodoc AUTHORS COPYING ChangeLog NEWS README* RELEASENOTES TODO
}

pkg_postinst()
{
	echo "To make GDM start at boot, edit /etc/rc.d/config/basic and then execute 'rc-update add gdm default'"
}

pkg_prerm()
{
	echo "To remove GDM from startup please execute 'rc-update del xdm default'"
}

