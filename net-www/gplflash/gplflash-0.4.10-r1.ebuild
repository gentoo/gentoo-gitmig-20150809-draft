# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Id: gplflash-0.4.10-r1.ebuild,v 1.4 2002/07/14 20:25:23 aliz Exp $

S=${WORKDIR}/flash-0.4.10
DESCRIPTION="GPL Shockwave Flash Player/Plugin"
SRC_URI="http://www.swift-tools.com/Flash/flash-0.4.10.tgz"
HOMEPAGE="http://www.swift-tools.com/Flash"
KEYWORDS="x86"

DEPEND="media-libs/libflash"

LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	cd ${WORKDIR}
	unpack flash-0.4.10.tgz
	cd ${S}
	patch -p1 <${FILESDIR}/${P}-gcc3-gentoo.diff || die
}

src_compile() {
	cd ${S}
	emake
}

src_install() {                               
  cd ${S}/Plugin
  insinto /opt/netscape/plugins
  doins npflash.so
  cd ${S}
  dodoc README COPYING
  
  if [ "`use mozilla`" ] ; then
    dodir /usr/lib/mozilla/plugins
    dosym /opt/netscape/plugins/npflash.so \
          /usr/lib/mozilla/plugins/npflash.so 
  fi
}
