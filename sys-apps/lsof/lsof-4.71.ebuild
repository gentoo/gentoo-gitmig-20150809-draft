# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lsof/lsof-4.71.ebuild,v 1.10 2004/11/05 23:33:55 lv Exp $

inherit flag-o-matic

MY_P=${P/-/_}
S=${WORKDIR}/${MY_P}/${MY_P}_src
DESCRIPTION="Lists open files for running Unix processes"
HOMEPAGE="ftp://vic.cc.purdue.edu/pub/tools/unix/lsof/README"
SRC_URI="ftp://vic.cc.purdue.edu/pub/tools/unix/lsof/${MY_P}.tar.gz
	ftp://ftp.cerias.purdue.edu/pub/tools/unix/sysutils/lsof/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 ~sparc x86"
IUSE="static"

DEPEND="virtual/libc"

#This pkg appears to be highly kernel-dependent.

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/${MY_P}
	tar xf ${MY_P}_src.tar || die
}

src_compile() {
	# #26576 lsof 4.68 compile with -fstack-protector fails on Alpha
	# -taviso (15 Aug 03)
	use alpha && filter-flags -fstack-protector

	use static && LDFLAGS="${LDFLAGS} -static"

	#interactive script: Enable HASSECURITY, WARNINGSTATE, and HASKERNIDCK
	#is there a way to avoid the "echo to a file + file read"?
	#Just piping in the results didn't seem to work.
	echo -e "y\ny\ny\nn\ny\ny\n" > ${T}/junk
	./Configure linux < ${T}/junk

	#simple Makefile hack to insert CFLAGS
	cp Makefile Makefile.orig
	sed \
		-e "s/-DLINUXV/${CFLAGS} -DLINUXV/" \
		-e "/^CFGL=/ s/\$/ ${LDFLAGS}/" \
		Makefile.orig > Makefile

	make all || die
}

src_install() {
	#/usr/sbin is a good location -- drobbins
	dosbin lsof || die
	# .a libs not needed during boot so they go in /usr/lib -- drobbins
	dolib lib/liblsof.a || die
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
