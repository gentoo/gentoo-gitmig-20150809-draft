# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lsof/lsof-4.64.ebuild,v 1.13 2003/04/14 16:49:09 gmsoft Exp $

MY_P=${P/-/_}
S=${WORKDIR}/${MY_P}/${MY_P}_src
DESCRIPTION="Lists open files for running Unix processes"
SRC_URI="ftp://vic.cc.purdue.edu/pub/tools/unix/lsof/${MY_P}.tar.gz
	ftp://ftp.cerias.purdue.edu/pub/tools/unix/sysutils/lsof/${MY_P}.tar.gz"
HOMEPAGE="ftp://vic.cc.purdue.edu/pub/tools/unix/lsof/README"

DEPEND="virtual/glibc"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa"

#This pkg appears to be highly kernel-dependent.

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/${MY_P}
	tar xf ${MY_P}_src.tar || die
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

src_install() {
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
