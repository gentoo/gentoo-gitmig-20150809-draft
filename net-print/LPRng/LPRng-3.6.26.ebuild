# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-print/LPRng/LPRng-3.6.26.ebuild,v 1.5 2001/05/29 17:28:19 achim Exp $

A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="Extended implementation of the Berkley LPR print spooler"
SRC_URI="ftp://ftp.astart.com/pub/LPRng/LPRng/${A}"
HOMEPAGE="http://www.astart.com/LPRng/LPRng.html"

PROVIDE="virtual/lpr"

DEPEND="virtual/glibc >=sys-libs/ncurses-5.2 >=sys-apps/procps-2.0.6 nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc >=sys-libs/ncurses-5.2"
src_unpack() {
  unpack ${A}
  cd ${S}/po
  rm Makefile.in.in
  cp /usr/share/gettext/po/Makefile.in.in .
  #rm -rf ${S}/intl
}

src_compile() {
  local myconf
  if [ "`use nls`" ] ; then
    myconf="--enable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/usr --sysconfdir=/etc/lprng \
	$myconf

  try make
}

src_install() {
  cd ${S}
  try make INSTALL_PREFIX=${D} datadir=${D}/usr/share \
		gnulocaledir=${D}/usr/share/locale \
		sysconfdir=${D}/etc/lprng \
		POSTINSTALL="NO" install

  # Fixing buggy mo installation
  rm -rf ${D}/usr/share/locale
  MOPREFIX=LPRng
  domo po/fr.po

  cd ${D}/usr/bin
  chgrp lp lpr lprm
  chmod g+s lpr lprm
  cd ${D}/usr/sbin
  chgrp lp lpc
  chmod 744 lpd
  chmod 555 lpc
  chmod g+s lpc
  dodir /var/spool/lpd/lp
  chmod 775 ${D}/var/spool/lpd
  chmod 755 ${D}/var/spool/lpd/lp
  chgrp -R lp ${D}/var/spool/lpd

  cd ${S}
  dodir /etc/rc.d/init.d
  cp ${FILESDIR}/lprng ${D}/etc/rc.d/init.d/lprng
  insopts -m 755
  insinto /usr/bin
  doins ${FILESDIR}/lpdomatic
  insinto /etc/lprng
  insopts -m 644
  doins printcap lpd.conf lpd.perms
  cd ${S}
  dodoc ABOUT-NLS.LPRng CHANGES CONTRIBUTORS COPYRIGHT LICENSE LINK README* UPDATE VERSION
  dodoc HOWTO/*.txt HOWTO/*.ppt
  docinto html
  dodoc HOWTO/*.html HOWTO/*.gif
}



