# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gdm/gdm-2.0_beta4-r2.ebuild,v 1.2 2001/06/05 19:43:20 achim Exp $

P=gdm-2.0beta4
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gdm"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/"${A}
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=sys-libs/pam-0.72
	>=sys-apps/tcp-wrappers-7.6
	>=gnome-base/gnome-libs-1.2.4"

RDEPEND=">=sys-libs/pam-0.72
	>=gnome-base/gnome-libs-1.2.4"

src_unpack() {
  unpack ${A}
  cd ${S}/daemon
  cp gdm.h gdm.h.orig
  sed -e "s:/var/gdm:/var/lib/gdm:" \
      -e "s:/usr/bin/X11:/usr/X11R6/bin:g" \
	gdm.h.orig > gdm.h
}

src_compile() {                           
  try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--sysconfdir=/etc/X11 --localstatedir=/var/lib

  try make
}

src_install() {                               
  try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/X11 \
	localstatedir=${D}/var/lib install
  mv ${D}/etc/X11/pam.d ${D}/etc
  cd ${D}/etc/X11/gdm
  for i in Init/Default PostSession/Default PreSession/Default gdm.conf
  do
    cp $i $i.orig
    sed -e "s:/usr/bin/X11:/usr/X11R6/bin:g" $i.orig > $i
    rm $i.orig
  done
  rm Sessions/*
  exeinto /etc/X11/gdm/Sessions
  doexe ${FILESDIR}/wm/{afterstep,blackbox,enlightenment,fvwm,gnome,icewm,kde,pwm,windowmaker,xfce}
  cd ${S}
  dodoc AUTHORS COPYING ChangeLog NEWS README* RELEASENOTES TODO
  docinto sgml
  dodoc docs/C/gdm.sgml
  docinto html
  dodoc docs/C/gdm.html
  docinto html/gdm
  dodoc docs/C/gdm/*.html

}




