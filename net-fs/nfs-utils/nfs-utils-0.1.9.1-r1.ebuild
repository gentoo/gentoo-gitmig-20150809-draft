# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-fs/nfs-utils/nfs-utils-0.1.9.1-r1.ebuild,v 1.5 2000/09/15 20:09:08 drobbins Exp $

P=nfs-utils-0.1.9.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Kernel NFS-Server"
SRC_URI="ftp://ftp.linuxnfs.sourceforge.org/pub/nfs/"${A}
HOMEPAGE="http://nfs.sourceforge.net"

src_compile() {
    try ./configure --mandir=${D}/usr/man --with-statedir=/var/state/nfs \
	--prefix=${D} --exec-prefix=${D}
    try make
}

src_install() {                 
	cd ${S}
	try make install STATEDIR=${D}/var/state/nfs
	prepman
	dodir /etc/rc.d/init.d
	cp ${O}/files/nfsserver ${D}/etc/rc.d/init.d
	cp ${O}/files/exports	${D}/etc
	dodoc ChangeLog COPYING README
	docinto linux-nfs
	dodoc linux-nfs/*
}
pkg_config() {

  . ${ROOT}/etc/rc.d/config/functions
  . ${ROOT}/var/db/pkg/install.config

  einfo "Generating symlinks..."
  ${ROOT}/usr/sbin/rc-update add nfsserver
  if [ -n "${nfsserver_home}" ]
  then
    einfo "Export Homedirs..."
    cp ${ROOT}/etc/exports ${ROOT}/etc/exports.orig
    sed -e "s:^#nfsserver_home:${nfsserver_home}:" \
	-e "s/eth0_net/${eth0_net}/" \
	-e "s/eth0_mask/${eth0_mask}/" \
	${ROOT}/etc/exports.orig > ${ROOT}/etc/exports
  fi
}




