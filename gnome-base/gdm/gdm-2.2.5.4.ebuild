# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gdm/gdm-2.2.5.4.ebuild,v 1.1 2002/01/03 08:32:28 hallski Exp $

MY_V="`echo ${PV} |cut -b -5`"
S=${WORKDIR}/${P}
DESCRIPTION="GNOME Display Manager"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.bz2"
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
	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc/X11				\
		    --localstatedir=/var/lib				\
		    --with-pam-prefix=/etc || die

	emake || die
}

src_install() {

	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc/X11					\
	     localstatedir=${D}/var/lib					\
	     PAM_PREFIX=${D}/etc					\
	     install || die

	rm -f ${D}/etc/pam.d/gdm

	# log
	mkdir -p ${D}/var/lib/gdm
	chown gdm:gdm ${D}/var/lib/gdm
	chmod 750 ${D}/var/lib/gdm
  
	# pam startup
	dodir /etc/pam.d
	insinto /etc/pam.d
	doins ${FILESDIR}/${MY_V}/pam.d/gdm
	doins ${FILESDIR}/${MY_V}/pam.d/gdmconfig

	# pam security
	dodir /etc/security/console.apps
	insinto /etc/security/console.apps
	doins ${FILESDIR}/${MY_V}/security/console.apps/gdmconfig

	# gnomerc
	dodir /etc/X11/gdm
	exeinto /etc/X11/gdm
	doexe ${FILESDIR}/${MY_V}/gnomerc

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
	    -e "s:GtkRC=/opt/gnome/share/themes/Default/gtk/gtkrc:GtkRC=/usr/share/themes/Default/gtk/gtkrc:g" \
	    -e "s:BackgroundColor=#007777:BackgroundColor=#2a3f5b:g" \
	    -e "s:TitleBar=true:TitleBar=false:g" \
		gdm.conf.orig > gdm.conf

	rm gdm.conf.orig

	cd ${S}
	
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README* TODO
}

pkg_postinst() {

	# Attempt to restart GDM softly by use of the fifo.  Wont work on older
	# then 2.2.3.1 versions but should work nicely on later upgrades.
	# FIXME: this is just way too complex
	FIFOFILE=`grep '^ServAuthDir=' /etc/X11/gdm/gdm.conf | sed -e 's/^ServAuthDir=//'`
	if test x$FIFOFILE = x ; then
		FIFOFILE=%{localstatedir}/gdm/.gdmfifo
	else
		FIFOFILE="$FIFOFILE"/.gdmfifo
	fi
	PIDFILE=`grep '^PidFile=' /etc/X11/gdm/gdm.conf | sed -e 's/^PidFile=//'`
	if test x$PIDFILE = x ; then
		PIDFILE=/var/run/gdm.pid
	fi
	if test -w $FIFOFILE ; then
		if test -f $PIDFILE ; then
			if kill -0 `cat $PIDFILE` ; then
				(echo;echo SOFT_RESTART) >> $FIFOFILE
			fi
		fi
	fi

	echo
	echo "***********************************************************************"
	echo "* To make GDM start at boot, edit /etc/rc.conf (or /etc/conf.d/basic) *"
	echo "* and then execute 'rc-update add xdm default'.                       *"
	echo "*                                                                     *"
	echo "* NOTE:  you need xfree-4.1.0-r4 or later ...                         *"
	echo "***********************************************************************"
	echo
}

pkg_postrm() {

	echo
	echo "**********************************************"
	echo "* To remove GDM from startup please execute  *"
	echo "* 'rc-update del xdm default'                *"
	echo "**********************************************"
	echo
}

