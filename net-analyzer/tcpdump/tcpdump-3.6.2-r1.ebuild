# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpdump/tcpdump-3.6.2-r1.ebuild,v 1.3 2002/07/18 15:01:43 nitro Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Tool for network monitoring and data acquisition"
SRC_URI="http://www.tcpdump.org/release/${A}
	 http://www.jp.tcpdump.org/release/${A}"
HOMEPAGE="http://www.tcpdump.org/"

DEPEND="virtual/glibc
	ssl? ( >=dev-libs/openssl-0.6.9 )
	>=net-libs/libpcap-0.6.2"

RDEPEND="virtual/glibc
	ssl? ( >=dev-libs/openssl-0.6.9 )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	# http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=49294
	patch -p1 < ${FILESDIR}/${P}-afsprinting.patch
	
}
src_compile() {
  local myconf
  if [ -z "`use ssl`" ] ; then
    myconf="--without-crypto"
  fi
  try ./configure --host=${CHOST} --prefix=/usr --enable-ipv6 $myconf
#--disable-ipv6
  try make CCOPT="$CFLAGS"
}

src_install() {                               
  into /usr
  dobin tcpdump
  doman tcpdump.1
  dodoc README FILES VERSION CHANGES
}



