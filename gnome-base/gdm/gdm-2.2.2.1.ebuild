# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joerg Krause <joerg@epost.de>

S=${WORKDIR}/${P}
DESCRIPTION="gdm"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=sys-libs/pam-0.72
	>=sys-apps/tcp-wrappers-7.6
	>=gnome-base/gnome-libs-1.2.4
	>=gnome-base/libglade-0.16-r1
	>=media-libs/gdk-pixbuf-0.11"

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
  #mv ${D}/etc/X11/pam.d ${D}/etc

  rm -rf ${D}/etc/X11/pam.d

  # log
  dodir /var
  dodir /var/lib
  dodir /var/lib/gdm
  chown gdm:gdm ${D}/var/lib/gdm
  chmod 750 ${D}/var/lib/gdm
  
  # pam startup
  dodir /etc/pam.d
  cd ${FILESDIR}/pam.d
  insinto /etc/pam.d
  doins gdm

  cd ${D}/etc/X11/gdm
  for i in Init/Default PostSession/Default PreSession/Default gdm.conf
  do
    cp $i $i.orig
    sed -e "s:/usr/bin/X11:/usr/X11R6/bin:g" $i.orig > $i
    rm $i.orig
  done

  # Background Picture
  dodir /opt/gnome/share
  dodir /opt/gnome/share/pixmaps
  insinto /opt/gnome/share/pixmaps
  doins ${FILESDIR}/gdm_background.jpg

  cd ${D}/etc/X11/gdm
  cp gdm.conf gdm.conf.orig
  sed -e "s:BackgroundType=2:BackgroundType=1:g" \
      -e "s:BackgroundImage=:BackgroundImage=/opt/gnome/share/pixmaps/gdm_background.jpg:g" \
      -e "s:BackgroundScaleToFit=true:BackgroundScaleToFit=false:g" \
      -e "s:GnomeDefaultSession:#GnomeDefaultSession:g" \
      -e "s:0=/usr/X11R6/bin/X:0=/usr/X11R6/bin/X -depth 16 -dpi 100 dpms vt12:g" \
      gdm.conf.orig > gdm.conf
  rm gdm.conf.orig
      
  rm Sessions/*
  exeinto /etc/X11/gdm/Sessions
  doexe ${FILESDIR}/wm/{afterstep,blackbox,enlightenment,fvwm,gnome,icewm,kde,pwm,windowmaker,xfce}
  cd ${S}
  dodoc AUTHORS COPYING ChangeLog NEWS README* RELEASENOTES TODO
}

pkg_postinst()
{
	rc-update add xdm
}

pkg_prerm()
{
	rc-update del xdm
}

