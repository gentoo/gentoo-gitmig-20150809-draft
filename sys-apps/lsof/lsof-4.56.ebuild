# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <g2boojum@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lsof/lsof-4.56.ebuild,v 1.1 2001/06/29 01:10:51 g2boojum Exp $

P=lsof_4.56
A=${P}_W.tar.gz
S0=${WORKDIR}
S=${WORKDIR}/${P}
DESCRIPTION="Lists open files for running Unix processes"
SRC_URI="ftp://vic.cc.purdue.edu/pub/tools/unix/lsof/${A}"
HOMEPAGE="http://"

DEPEND=""

src_unpack() {
    unpack ${A}
    cd ${S0}
    try tar xvf ${P}.tar
}

src_compile() {

    #interactive script: Enable HASSECURITY, WARNINGSTATE, and HASKERNIDCK
    #is there a way to avoid the "echo to a file + file read"?
    #Just piping in the results didn't seem to work.
    echo -e "y\ny\ny\nn\ny\ny\n" > junk
    ./Configure linux < junk
    try make all

}

src_install () {

    doman lsof.8
    exeinto /bin/
    doexe lsof
    into /lib
    dolib lib/liblsof.a
    dodoc 00*
    insinto /usr/share/lsof/scripts
    doins scripts/*
}

