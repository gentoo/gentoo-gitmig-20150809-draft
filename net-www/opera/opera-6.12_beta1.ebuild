# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/opera/opera-6.12_beta1.ebuild,v 1.3 2003/08/24 16:21:28 weeve Exp $

# Based on original Gentoo Techonologies opera ebuild
# Modified by Gustavo Zacarias <gustavo at zacarias.com.ar> for sparc

DESCRIPTION="Opera web browser."
HOMEPAGE="http://www.opera.com/linux/"
IUSE="gnome kde"

RDEPEND="virtual/x11"

SLOT="0"
LICENSE="OPERA"
KEYWORDS="-* sparc"

NV=6.12-20030306.1-static-qt.sparc
SRC_URI="ftp://ftp.opera.com/pub/opera/linux/612/beta1/en/sparc/static/opera-${NV}.tar.gz"
S=${WORKDIR}/opera-${NV}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "s:/etc:${D}/etc:g" \
	    -e "s:config_dir=\"/etc\":config_dir=\"${D}/etc/\":g" \
	    -e "s:read install_config:install_config=yes:" \
	    -e "s:/opt/kde2:${D}/usr/kde/2:g" \
	    -e "s:/opt/kde2:${D}/usr/kde/2:g" \
	    -e "s:/usr/share/applnk:${D}/usr/share/applnk:g" \
	    -e "s:/usr/share/pixmaps:${D}/usr/share/pixmaps:g" \
	    -e "s:/usr/share/icons:${D}/usr/share/icons:g" \
	    -e "s:/etc/X11:${D}/etc/X11:g" \
	    -e "s:/usr/share/gnome:${D}/usr/share/gnome:g" \
	    -e 's:#\(LD_PRELOAD=.*libawt.so\):\1:' \
	    -e 's:#\(OPERA_FORCE_JAVA_ENABLED=\):\1:' \
	    -e 's:#\(export LD_PRELOAD OPERA_FORCE_JAVA_ENABLED\):\1:' \
	    < install.sh >install.sh.hacked || die
	mv install.sh.hacked install.sh
	chmod +x install.sh

}

src_install() {
	# Prepare installation directories for Opera's installer script.
	dodir /etc
	if [ "`use kde`" ]
	then
		# Install stuff for KDE2, and then simply copy it over
		# into the KDE3 directories.
		dodir /usr/kde/2/share/icons/{locolor,hicolor}/{16x16,22x22,32x32,48x48}/apps
		dodir /usr/kde/2/share/applnk/Internet
	fi
	if [ "`use gnome`" ]
	then
		dodir /usr/share/gnome/pixmaps
		dodir /usr/share/gnome/apps/Internet
	fi

	# Opera's native installer.
	./install.sh --prefix="${D}"/opt/opera || die
	if [ "`use kde`" ]
	then
		cp -R ${D}/usr/kde/2 ${D}/usr/kde/3
	fi
	rm ${D}/opt/opera/share/doc/opera/help
	dosym /opt/share/doc/opera/help /opt/opera/share/opera/help

	dosed /opt/opera/bin/opera
	dosed /opt/opera/share/opera/java/opera.policy

	# Install the icons
	insinto /usr/share/icons /etc/X11/wmconfig /etc/X11/applnk/Internet \
		/usr/share/pixmaps
	doins images/opera.xpm
	
	# Install a symlink /usr/bin/opera
	dodir /usr/bin
	dosym /opt/opera/bin/opera /usr/bin/opera
}
