# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

A=plugger-4.0-linux-x86-glibc.tar.gz
S=${WORKDIR}/plugger-4.0
DESCRIPTION="Plugger 4.0 streaming media plugin"
SRC_URI="http://fredrik.hubbe.net/plugger/"${A}
HOMEPAGE="http://fredrik.hubbe.net/plugger.html"
SLOT="0"
KEYWORDS="x86"

src_install() {                               
  cd ${S}
  dodir /opt/netscape/plugins /etc /usr/local/bin
  insinto /opt/netscape/plugins
  doins plugger.so
  insinto /etc
  doins pluggerrc
  dodoc README COPYING
  doman plugger.7
  insinto /usr/bin
  dobin plugger-4.0
  dosym plugger-4.0 /usr/bin/plugger
}
