# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lsof/lsof-4.60-r1.ebuild,v 1.6 2002/07/16 05:50:59 seemant Exp $

MY_P=${P/-/_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Lists open files for running Unix processes"
SRC_URI="ftp://vic.cc.purdue.edu/pub/tools/unix/lsof/${MY_P}_W.tar.gz
	ftp://ftp.cerias.purdue.edu/pub/tools/unix/sysutils/lsof/${MY_P}_W.tar.gz"
HOMEPAGE="http://"
KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc virtual/linux-sources"

#This pkg appears to be highly kernel-dependent.

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	tar xf ${MY_P}.tar || die
	cd ${S}
}

src_compile() {
	#interactive script: Enable HASSECURITY, WARNINGSTATE, and HASKERNIDCK
	#is there a way to avoid the "echo to a file + file read"?
	#Just piping in the results didn't seem to work.
	echo -e "y\ny\ny\nn\ny\ny\n" > ${T}/junk
	./Configure linux < ${T}/junk
	
	#simple Makefile hack to insert CFLAGS
	cp Makefile Makefile.orig
	sed -e "s/-DLINUXV/${CFLAGS} -DLINUXV/" Makefile.orig > Makefile
	
	make all || die
}

src_install () {
	#/usr/sbin is a good location -- drobbins
	dosbin lsof
	# .a libs not needed during boot so they go in /usr/lib -- drobbins
	dolib lib/liblsof.a
	insinto /usr/share/lsof/scripts
	doins scripts/*
	doman lsof.8
	local x
	for x in 00*
	do
		newdoc ${x} ${x/00/}
	done
	cd ${D}/usr/share/doc/${PF}
	mv .README.FIRST.gz README.FIRST.gz
}

