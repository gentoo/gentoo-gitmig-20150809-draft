# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author AJ Lewis <aj@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/twin/twin-0.2.8.ebuild,v 1.3 2001/08/30 17:31:35 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A text-mode window environment"
SRC_URI="http://ftp1.sourceforge.net/twin/${A}
	 http://linuz.sns.it/~max/twin/${A}"
HOMEPAGE="http://linuz.sns.it/~max/twin/" 
DEPEND="virtual/glibc
	X? ( virtual/x11 )
        >=sys-libs/ncurses-5.2"

src_unpack() {
   unpack ${A}
   cd ${S}
   try patch -p1 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
   local conf
   
   conf="\n\n\n\n\n\n\n\n"
   if [ "`use X`" ]
   then
      conf=${conf}"y\n"
   else
      conf=${conf}"n\n"
   fi
   conf=${conf}"\n\n\n\n\n"
   echo -e ${conf} > .temp
   cat .temp | make config
   rm .temp
   try make clean
   try make 
}

src_install() {
   
   dodir /usr/lib /usr/bin /usr/lib/ /usr/include

   dobin server/twin_real server/twin_wrapper
   dobin clients/twsetroot clients/twevent clients/twmapscrn \
         clients/twedit clients/twterm clients/twattach clients/twsysmon

   dolib lib/libTw.so.1.0.0 

   insinto /usr/include
     doins include/libTwkeys.h include/libTw.h include/libTwerrno.h

   dosym /usr/bin/twin_wrapper /usr/bin/twin
   dosym /usr/bin/twattach /usr/bin/twdetach
   dosym /usr/lib/libTw.so.1.0.0 /usr/lib/libTw.so.1
   dosym /usr/lib/libTw.so.1 /usr/lib/libTw.so

   dodoc BUGS COPYING COPYING.LIB INSTALL README TODO Changelog.txt ${P}.lsm
   docinto clients
     dodoc clients/README.twsetroot clients/twsetroot.sample
}
