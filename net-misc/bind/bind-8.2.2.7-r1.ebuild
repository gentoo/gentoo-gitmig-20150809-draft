# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/bind/bind-8.2.2.7-r1.ebuild,v 1.2 2000/11/17 03:05:48 achim Exp $

A=bind-src.tar.gz
S=${WORKDIR}/src
DESCRIPTION="Name Server"
SRC_URI="ftp://ftp.isc.org/isc/bind/src/8.2.2-P7/"${A}
HOMEPAGE="http://www.isc.org/products/BIND"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3"

src_compile() {                           
#    unset O A
    try make depend 
#    cd ${S}/bin
#    cp Makefile Makefile.orig
#    sed -e 's/CDEBUG= -g/#CDEBUG= -g/' Makefile.orig > Makefile
#    cp Makefile Makefile.orig
#    sed -e 's/CFLAGS=/#CFLAGS=/' Makefile.orig > Makefile
#    cd ${S}/lib
#    cp Makefile Makefile.orig
#    sed -e "s:^SYSTYPE=.*:SYSTYPE=linux:" Makefile.orig > Makefile
#    for i in ${S}/bin/*/Makefile
#    do 
#      cp $i $i.orig
#      sed -e "s:^SYSTYPE=.*:SYSTYPE=linux:" $i.orig > $i
#    done
    try make clean
    try make all
}

src_unpack() {

    unpack ${A}
    cd ${S}/port/linux
    cp Makefile.set Makefile.set.orig
#    sed -e 's/CDEBUG=-O -g/CDEBUG=${CFLAGS}/' Makefile.set.orig > Makefile.set
    cp Makefile.set Makefile.set.orig
    sed -e 's/DESTETC=\/etc/DESTETC=\/etc\/bind/' \
	-e "s:^'SYSLIBS=.*':'SYSLIBS=-L/usr/lib -lfl':" \
	Makefile.set.orig > Makefile.set
    echo "'SYSTYPE=linux'" >> Makefile.set


}

src_install() {
	into /usr
	for x in addr dig dnsquery host mkservdb nslookup nsupdate
	do
		dobin bin/${x}/${x}
	done	
	for x in dnskeygen irpd named named-bootconf named-xfer ndc
	do
		dosbin bin/${x}/${x}
	done

	dodoc CHANGES DNSSEC SUPPORT README LICENSE* TODO 
	docinto conf
	dodoc conf/README	
	docinto conf/recursive
	dodoc conf/recursive/* 
	docinto conf/recursive/pri
	dodoc conf/recursive/pri/* 
	docinto conf/workstation
	dodoc conf/workstation/* 
	docinto conf/workstation/pri
	dodoc conf/workstation/pri/* 
	dodir /etc/rc.d/init.d
	cp ${O}/files/named ${D}/etc/rc.d/init.d
	cp ${O}/files/named.conf ${D}/usr/doc/${PF}/conf/workstation/named.conf.gentoolinux
	dodir /etc/bind
	dodir /var/bind
}

pkg_config() {

    . ${ROOT}/etc/rc.d/config/functions

    if [ -e ${ROOT}/etc/bind/named.conf ]; then
	echo "You already have a named.conf in ${ROOT}/etc/bind/named.conf, not creating one."
    else
	install -m0644 ${ROOT}/usr/doc/${PF}/conf/workstation/named.conf.gentoolinux ${ROOT}/etc/bind/named.conf
	mkdir ${ROOT}/var/bind/pri
	gzip -d ${ROOT}/usr/doc/${PF}/conf/workstation/root.cache.gz
	gzip -d ${ROOT}/usr/doc/${PF}/conf/workstation/pri/*.gz
	install -m0644 ${ROOT}/usr/doc/${PF}/conf/workstation/root.cache ${ROOT}/var/bind/root.cache
	install -m0644 ${ROOT}/usr/doc/${PF}/conf/workstation/pri/* ${ROOT}/var/bind/pri/
    fi
    echo; 
    ${ROOT}/usr/sbin/rc-update add named 
    echo; einfo "BIND enabled."
}

