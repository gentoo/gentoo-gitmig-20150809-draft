# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/licq/licq-1.2.6.ebuild,v 1.1 2003/04/22 22:36:12 drobbins Exp $

IUSE="ssl socks5 qt kde gtk ncurses"

DESCRIPTION="ICQ Client with v8 support" 
HOMEPAGE="http://www.licq.org"
LICENSE="GPL-2"

inherit kde-base
need-kde 3.0

#we can't have conditional dependencies so "use kde && inherit kde-base" 
#won't work -- messes up dep caching.

#need-kde and their eclass friends inject things into DEPEND. But we only
#want them enabled if the kde USE flag is set. We get around this in the
#following dep lines:

RDEPEND="kde? ( $DEPEND )"
DEPEND="kde? ( $DEPEND )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	qt?  ( >=x11-libs/qt-3.0.0 )
	gtk? ( =x11-libs/gtk+-1.2* )
	ncurses? ( sys-libs/ncurses )"

SRC_URI="http://download.sourceforge.net/licq/${P}.tar.bz2"
SLOT="2"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}
	
	if [ "`use kde`" ]
	then
		# fix for #12436
		ebegin "Setting kde plugin as default..."
		cp ${S}/src/licq.conf.h ${T}
		sed "s:Plugin1 = qt-gui:Plugin1 = kde-gui:" \
			${T}/licq.conf.h > ${S}/src/licq.conf.h
		eend $?
	else
		if [ -z "`use qt`" ]
		then
			if [ -z "`use gtk`" ]
			then
				ebegin "Setting console plugin as default..."
				cp ${S}/src/licq.conf.h ${T}
				sed "s:Plugin1 = qt-gui:Plugin1 = console:" \
					${T}/licq.conf.h > ${S}/src/licq.conf.h
				eend $?
			else
				ebegin "Setting GTK plugin as default..."
				cp ${S}/src/licq.conf.h ${T}
				sed "s:Plugin1 = qt-gui:Plugin1 = jons-gtk-gui:" \
					${T}/licq.conf.h > ${S}/src/licq.conf.h
				eend $?
			fi
		fi
	fi
}

src_compile() {

	local first_conf
	use ssl		|| first_conf="${first_conf} --disable-openssl"
	use socks5	&& first_conf="${first_conf} --enable-socks5"

	econf ${first_conf} || die
	emake || die

	
	# Create the various plug-ins

	# First, the Qt plug-in
	if [ "`use qt`" ] 
	then
		# A hack to build against the latest QT:
		local v
		for v in /usr/qt/[0-9]
		do
			[ -d "${v}" ] && export QTDIR="${v}"
		done
		use kde && kde_src_compile myconf
		use kde && second_conf="${second_conf} ${myconf} --with-kde"

		# note! watch the --prefix=/usr placement;
		# licq itself installs into /usr, but the
		# optional kde/qt interface (to which second_conf belogns)
		# installs its files in $KDE3DIR/{lib,share}/licq

		cd ${S}/plugins/qt-gui
		einfo "Compiling Qt GUI plug-in"
		econf ${second_conf} || die
		emake || die
	fi

	# Now Jon's GTK plug-in
	if [ "`use gtk`" ]
	then
		cd ${S}/plugins/jons-gtk-gui
		einfo "Compiling GTK GUI plug-in"
		econf || die
		emake || die
	fi

	# Now the console plug-in
	if [ "`use ncurses `" ]
	then
	    cd ${S}/plugins/console
	    einfo "Compiling the Console plug-in"
	    econf || die
	    emake || die
	fi

	# The Auto-Responder plug-in
	cd ${S}/plugins/auto-reply
	einfo "Compiling the Auto-Reply plug-in"
	econf || die
	emake || die

	# The Remote Management Service
	cd ${S}/plugins/rms
	einfo "Compiling Remote Management Services plug-in"
	econf || die
	emake || die
}

src_install() {

	cd ${S}
	make DESTDIR=${D} install || die

	dodoc ChangeLog INSTALL README*

	# Install the plug-ins
	if [ "`use qt`" ] 
	then
		cd ${S}/plugins/qt-gui
		make DESTDIR=${D} install || die	
		docinto plugins/qt-gui
		dodoc README*
		
		# fix bug #12436, see my comment there
##		if [ "`use kde`" ]; then
##			cd $D/usr/lib/licq
##			ln -s licq_kde-gui.la licq_qt-gui.la
##			ln -s licq_kde-gui.so licq_qt-gui.so
##		fi
	fi

	if [ "`use gtk`" ]
	then
		cd ${S}/plugins/jons-gtk-gui
		make DESTDIR=${D} install || die
		docinto plugins/jons-gtk-gui
		dodoc TODO
	fi

	if [ "`use ncurses`" ]
	then
	    cd ${S}/plugins/console
	    make DESTDIR=${D} install || die
	    docinto plugins/console
	    dodoc README
	fi


	cd ${S}/plugins/auto-reply
	make DESTDIR=${D} install || die
	docinto plugins/auto-reply
	dodoc README licq_autoreply.conf

	cd ${S}/plugins/rms
	make DESTDIR=${D} install || die
	docinto plugins/rms
	dodoc README licq_rms.conf
}
