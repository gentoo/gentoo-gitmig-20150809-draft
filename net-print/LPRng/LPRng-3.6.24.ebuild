# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-print/LPRng/LPRng-3.6.24.ebuild,v 1.3 2000/11/01 04:44:23 achim Exp $

P=LPRng-3.6.24
A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="Extended implementation of the Berkley LPR print spooler"
SRC_URI="ftp://ftp.astart.com/pub/LPRng/LPRng/${A}"
HOMEPAGE="http://www.astart.com/LPRng/LPRng.html"

DEPEND=">=sys-libs/glibc-2.1.3"

src_unpack() {
  unpack ${A}
  cd ${S}/po
  rm Makefile.in.in
  cp /usr/share/gettext/po/Makefile.in.in .
  rm -rf ${S}/intl
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr --sysconfdir=/etc/lprng \
	--enable-nls --with-catgets --with-included-gettext
  try make
}

src_install() {                               
  cd ${S}
  try make INSTALL_PREFIX=${D} datadir=${D}/usr/share gnulocaledir=${D}/usr/share/locale install

  prepman

  rm -rf ${D}/usr/share/locale
  MOPREFIX=LPRng
  domo po/fr.po
  cp ${O}/files/lprng ${D}/etc/rc.d/init.d/lprng
  cd ${S}
  dodoc ABOUT-NLS.LPRng CHANGES CONTRIBUTORS COPYRIGHT LICENSE LINK README* UPDATE VERSION
  dodoc HOWTO/*.txt HOWTO/*.ppt
  docinto html
  dodoc HOWTO/*.html HOWTO/*.gif
}



