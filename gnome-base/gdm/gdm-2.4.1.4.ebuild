# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gdm/gdm-2.4.1.4.ebuild,v 1.1 2003/05/13 17:50:08 foser Exp $

inherit eutils gnome2

DESCRIPTION="GNOME2 Display Manager"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
LICENSE="GPL-2"
IUSE=""
SRC_URI="${SRC_URI}
	mirror://gentoo/gentoo-gdm-theme.tar.bz2"
MY_V="`echo ${PV} |cut -b -5`"

RDEPEND=">=sys-libs/pam-0.72
	>=sys-apps/tcp-wrappers-7.6
	>=x11-libs/gtk+-2
	>=gnome-base/libglade-2
	>=gnome-base/librsvg-2
	>=dev-libs/libxml2-2.4.12
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomecanvas-2"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.3.11
	>=x11-base/xfree-4.2.0-r3"

src_unpack() {
	unpack ${A}

	cd ${S}/daemon
	cp gdm.h gdm.h.orig
	sed -e "s:/usr/bin/X11:/usr/X11R6/bin:g" \
		gdm.h.orig > gdm.h
	rm -f gdm.h.orig

	# Make Gentoo theme default	
	cd ${S}/config
	cp gdm.conf.in gdm.conf.in.orig
	sed -e "s:/usr/bin/X11:/usr/X11R6/bin:g" \
		-e "s:=circles:=gentoo-emergence:" \
		-e "s:command=/usr/X11R6/bin/X:command=/usr/X11R6/bin/X -nolisten tcp:" \
		gdm.conf.in.orig > gdm.conf.in

	rm -f gdm.conf.in.orig
}

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc/X11 \
		--localstatedir=/var/lib \
		--with-pam-prefix=/etc \
		${myconf} || die
		
	emake || die
}

src_install() {
	cd omf-install
	cp Makefile Makefile.old
	sed -e "s:scrollkeeper-update.*::g" \
		Makefile.old > Makefile
	rm Makefile.old
	cd ${S}

	make prefix=${D}/usr \
		sysconfdir=${D}/etc/X11 \
		localstatedir=${D}/var/lib \
		PAM_PREFIX=${D}/etc \
		install || die

	# We need to move gdm-binary to gdm, else our xdm script
	# have problems stopping gdm (bug #5598)
	rm -f ${D}/usr/bin/gdm
	mv ${D}/usr/bin/gdm-binary ${D}/usr/bin/gdm

	rm -f ${D}/etc/pam.d/gdm

	# log
	dodir /var/lib/gdm
	chown gdm:gdm ${D}/var/lib/gdm
	chmod 0750 ${D}/var/lib/gdm
  
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
		cp ${i} ${i}.orig
		sed -e s:/usr/bin/X11:/usr/X11R6/bin:g \
			${i}.orig > ${i}
		rm ${i}.orig
	done

	cd ${D}/etc/X11/gdm
	cp gdm.conf gdm.conf.orig
	
	sed -e "s:0=/usr/X11R6/bin/X:0=/usr/X11R6/bin/X -dpi 100 -nolisten tcp dpms vt7:g" \
	    -e "s:GtkRC=/opt/gnome/share/themes/Default/gtk/gtkrc:GtkRC=/usr/share/themes/Default/gtk/gtkrc:g" \
	    -e "s:BackgroundColor=#007777:BackgroundColor=#2a3f5b:g" \
	    -e "s:TitleBar=true:TitleBar=false:g" \
		-e "s:Greeter=/usr/bin/gdmlogin:Greeter=/usr/bin/gdmgreeter:g" \
		gdm.conf.orig > gdm.conf

	rm gdm.conf.orig

	cd ${S}

	# Support for new session stuff
	rm -rf ${D}/etc/X11/gdm/Sessions
	dosym ../Sessions /etc/X11/gdm/Sessions

	# Make sure the users environment are set properly
	# (bash users only though :( )
	dosed "s:#!/bin/sh:#!/bin/bash --login:g" /etc/X11/gdm/PreSession/Default

	# Move Gentoo theme in
	mv ${WORKDIR}/gentoo-emergence  ${D}/usr/share/gdm/themes
	
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README* TODO
}

pkg_preinst() {
	#support for new session stuff
	if [ -d ${ROOT}/etc/X11/gdm/Sessions -a ! -L ${ROOT}/etc/X11/gdm/Sessions ]
	then
		mv -f ${ROOT}/etc/X11/gdm/Sessions ${ROOT}/etc/X11/gdm/Sessions.old
	fi
}

pkg_postinst() {
	gnome2_scrollkeeper_update

	# Attempt to restart GDM softly by use of the fifo.  Wont work on older
	# then 2.2.3.1 versions but should work nicely on later upgrades.
	# FIXME: this is just way too complex
	FIFOFILE="${ROOT}`grep '^ServAuthDir=' ${ROOT}/etc/X11/gdm/gdm.conf | sed -e 's/^ServAuthDir=//'`"
	if [ -z "${FIFOFILE}" ]
	then
		FIFOFILE=${ROOT}/var/lib/gdm/.gdmfifo
	else
		FIFOFILE=${FIFOFILE}/.gdmfifo
	fi
	PIDFILE="${ROOT}`grep '^PidFile=' ${ROOT}/etc/X11/gdm/gdm.conf | sed -e 's/^PidFile=//'`"
	if [ -z "${PIDFILE}" ]
	then
		PIDFILE=${ROOT}/var/run/gdm.pid
	fi
	if [ -w ${FIFOFILE} ]
	then
		if [ -f ${PIDFILE} ]
		then
			if kill -0 `cat ${PIDFILE}`
			then
				(echo;echo SOFT_RESTART) >> ${FIFOFILE}
			fi
		fi
	fi

	# Unmerge nukes sometimes
	if [ ! -d ${ROOT}/var/lib/gdm ]
	then
		mkdir -p ${ROOT}/var/lib/gdm
		chown gdm.gdm ${ROOT}/var/lib/gdm
		chmod 0750 ${ROOT}/var/lib/gdm
	fi
	touch ${ROOT}/var/lib/gdm/.keep

	echo ""
	einfo "To make GDM start at boot, edit /etc/rc.conf (or /etc/conf.d/basic)"
	einfo "and then execute 'rc-update add xdm default'."
	einfo ""
	einfo "Note that you need xfree-4.1.0-r4 or later."
}

pkg_postrm() {
	gnome2_scrollkeeper_update

	echo ""
	einfo "To remove GDM from startup please execute"
	einfo "'rc-update del xdm default'"
}
