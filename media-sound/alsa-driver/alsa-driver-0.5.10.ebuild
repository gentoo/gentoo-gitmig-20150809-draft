# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-driver/alsa-driver-0.5.10.ebuild,v 1.4 2001/01/18 18:22:11 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Advanced Linux Sound Architecture / Drivers"
SRC_URI="ftp://ftp.alsa-project.org/pub/driver/${P}.tar.bz2"
HOMEPAGE="http://www.alsa-project.org/"
KERNEL="linux-2.4.0.8"
MODULES=2.4.0-ac8/misc/alsa/

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr \
	--with-kernel=/usr/src/linux \
	--with-moddir=/lib/modules/${MODULES} \
	--with-isapnp=yes 
  try make
}

src_install() {                               
  cd ${S}
  into /usr
  dosbin snddevices
  insinto /lib/modules/${MODULES}
  doins modules/*.o
  insinto /usr/src/linux/include/linux
  for i in asound asoundid asequencer ainstr_simple ainstr_gf1 ainstr_iw
  do
    doins include/$i.h
  done
  insinto /etc/rc.d/init.d
  doins utils/alsasound
  dodoc COPYING FAQ README WARNING doc/README.1st doc/SOUNDCARDS
}





