# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-fs/nfs-utils/nfs-utils-0.2.1-r3.ebuild,v 1.4 2001/06/09 20:17:34 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Kernel NFS-Server"
SRC_URI="ftp://ftp.linuxnfs.sourceforge.org/pub/nfs/"${A}
HOMEPAGE="http://nfs.sourceforge.net"

DEPEND="virtual/glibc
        tcpd? ( sys-apps/tcp-wrappers )"

RDEPEND="virtual/glibc net-nds/portmap"
src_unpack() {
    unpack ${A}
    patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
    try ./configure --mandir=${D}/usr/share/man --with-statedir=/var/lib/nfs \
	--prefix=${D} --exec-prefix=${D}
    if [ -z "`use tcpd`" ] ; then
      cp config.mk config.mk.orig
      sed -e "s:-lwrap::" -e "s:-DHAVE_TCP_WRAPPER::" \
        config.mk.orig > config.mk
    fi
    try make
}

src_install() {

	try make install STATEDIR=${D}/var/lib/nfs
	dodir /etc/rc.d/init.d
	cp ${FILESDIR}/nfs       ${D}/etc/rc.d/init.d
	cp ${FILESDIR}/exports	${D}/etc
	dodoc ChangeLog COPYING README
	docinto linux-nfs
	dodoc linux-nfs/*
}
pkg_config() {

  . ${ROOT}/etc/rc.d/config/functions
  . ${ROOT}/var/db/pkg/install.config

  echo "Generating symlinks..."
  ${ROOT}/usr/sbin/rc-update add nfs
  if [ -n "${nfsserver_home}" ]
  then
    echo "Export Homedirs..."
    cp ${ROOT}/etc/exports ${ROOT}/etc/exports.orig
    sed -e "s:^#nfsserver_home:${nfsserver_home}:" \
	-e "s/eth0_net/${eth0_net}/" \
	-e "s/eth0_mask/${eth0_mask}/" \
	${ROOT}/etc/exports.orig > ${ROOT}/etc/exports
  fi
}




