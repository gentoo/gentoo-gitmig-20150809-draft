# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/opera/opera-5.0.ebuild,v 1.1 2001/05/15 16:39:31 achim Exp $

P=opera-5.0-dynamic.i386
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Opera webbrowser"
SRC_URI="ftp://ftp.opera.com/pub/opera/linux/500/opera-5.0-dynamic.i386.tar.gz"
HOMEPAGE="http://www.opera.com"


src_install() {

  T=/usr/X11R6
  exeinto $T/bin
  doexe opera

  insinto $T/share/opera/buttons
  doins buttons/*
  insinto $T/share/opera/buttons/default
  doins buttons/default/*

  insinto $T/share/opera/help
  doins help/*

  insinto $T/share/opera/images
  doins images/*

  insinto $T/share/opera/styles
  doins styles/*

  insinto $T/share/opera
  doins opera.xpm opera.wmconfig opera.desktop opera_*.png
  doins opera.adr

  insinto /etc/skel/.opera
  doins opera.adr

  insinto /usr/X11R6/share/pixmaps
  doins opera.xpm

  insinto /etc/X11/wmconfig
  doins opera.wmconfig

  if [ "`use gnome`" ] ; then
	insinto /opt/gnome/share/pixmaps
	doins opera.xpm
	insinto /opt/gnome/share/gnome/apps/Internet
	doins opera.desktop
  fi

  if [ "`use kde`" ] ; then
	dodir ${KDEDIR}/share/icons/{hi,lo}color
	for i in 48x48 32x32 22x22
	do
	  cp opera_${i}.png ${D}/${KDEDIR}/share/icons/hicolor
	  cp opera_${i}.png ${D}/${KDEDIR}/share/icons/locolor
	done
	insinto ${KDEDIR}/share/applnk/Internet
	doins opera.desktop
  fi
  insinto /etc/env.d
  doins ${FILESDIR}/10opera
  dodoc LICENSE
}

