# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-fs/netatalk/netatalk-1.4_beta2-r1.ebuild,v 1.4 2000/11/01 04:44:19 achim Exp $

P=netatalk-1.4b2
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Apple-Talk"
SRC_URI="ftp://terminator.rsug.itd.umich.edu/unix/netatalk/"${A}
HOMEPAGE="http://www.umich.edu/~rsug/netatalk/"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3"

src_compile() {                           
  cd ${S}/include/netatalk
  cp endian.h endian.h.orig
  sed -e "s/<bytesex\.h>/<asm\/ioctls\.h>/" endian.h.orig > endian.h
  cd ${S}
  make LDFLAGS="-lcrypt" OPTOPTS="${CFLAGS} -fsigned-char" DESTDIR=/usr ETCDIR=/etc/atalk \
	RESDIR=/usr/libexec/atalk SBINDIR=/usr/sbin
}

src_install() {                               
  cd ${S}
  dodir /etc/atalk
  dodir /usr/libexec
  into /usr

  dobin bin/aecho/aecho bin/getzones/getzones bin/megatron/megatron
  dobin bin/nbp/nbplkup bin/nbp/nbprgstr bin/nbp/nbpunrgstr
  dobin bin/pap/pap bin/pap/papstatus bin/psorder/psorder

  for i in single2bin unbin unhex unsingle hqx2bin macbinary
  do
    dosym /usr/bin/megatron /usr/bin/$i 
  done

  insinto /etc/atalk
  doins config/*

  dosbin etc/afpd/afpd etc/atalkd/atalkd etc/papd/papd 
  dosbin etc/psf/psa etc/psf/psf 
  cp etc/psf/etc2ps.sh ${D}/usr/sbin/etc2ps

  insinto /usr/include/atalk
  doins include/atalk/*

  insinto /usr/include/netatalk
  doins include/netatalk/*

  dolib.a libatalk/libatalk.a libatalk/libatalk_p.a

  doman man/man1/*.1 man/man3/*.3 man/man4/*.4 man/man8/*.8

  insinto /usr/libexec/atalk/filters

  doins etc/psf/pagecount.ps

  for i in ofpap ifpap tfpap ifpaprev tfpaprev ofwpap ifwpap ifwpaprev \
	   tfwpaprev ofmpap ifmpap tfmpap ifmpaprev tfmpaprev ofwmpap \
	   ifwmpap tfwmpap ifwmpaprev tfwmpaprev tfwpap
  do
	dosym /usr/sbin/psf /usr/libexec/atalk/filters/$i 
  done

  cd ${S}

  dodir /etc/rc.d/init.d
  cp ${O}/files/atalk ${D}/etc/rc.d/init.d/atalk
  dodoc BUGS CHANGES README* COPYRIGHT VERSION 

}




