# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/vcron/vcron-3.0_p1-r1.ebuild,v 1.3 2000/11/30 23:14:35 achim Exp $

P=vcron-3.0p1
A=cron3.0pl1.tar.gz
S=${WORKDIR}/cron3.0pl1
DESCRIPTION="Crontab Daemon"
SRC_URI="ftp://sunsite.unc.edu/pub/Linux/system/daemons/cron/"${A}
DEPEND=">=sys-libs/glibc-2.1.3"

src_unpack() {
  unpack ${A}
  cd ${S}
  cp Makefile Makefile.orig
  sed -e "s/^OPTIM.*/OPTIM = ${CFLAGS}/" Makefile.orig > Makefile
}

src_compile() {                           
  cd ${S}
  try pmake
}

src_install() {                               
  cd ${S}
  into /usr
  dobin cron
  dosbin crontab
  doman crontab.[15] cron.8
  dodoc CHANGES CONVERSION FEATURES MAIL MANIFEST README THANKS
}



