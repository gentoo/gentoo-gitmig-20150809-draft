# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Prakash Shetty (Crux) <ps@gnuos.org>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="POP Server with support for Maildir,Virtual Domains,Multiple IP's etc"
SRC_URI="http://ftp.toontown.org/pub/teapop/${A}"
HOMEPAGE="http://www.toontown.org/teapop/"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --enable-lock=flock --disable-apop\
    --enable-homespool=Maildir
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc doc/CREDITS doc/ChangeLog doc/INSTALL 
}

pkg_config() {
	echo "This config script will add tpop lines to your /etc/xinetd.conf."
	echo "Press control-C to abort, hit Enter to continue."
	echo
	read
	cat ${FILESDIR}/tpop.xinetd >> ${ROOT}etc/xinetd.conf
	echo "Modifications applied."
}
