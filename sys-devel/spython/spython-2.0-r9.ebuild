# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/spython/spython-2.0-r9.ebuild,v 1.12 2003/09/05 02:08:20 msterret Exp $

inherit eutils

IUSE="readline build"

S=${WORKDIR}/Python-2.0
S2=${WORKDIR}/python-fchksum-1.1
DESCRIPTION="A really great language -- minimalist python environment"
SRC_URI="http://www.python.org/ftp/python/2.0/BeOpen-Python-2.0.tar.bz2
	 http://www.azstarnet.com/~donut/programs/fchksum/python-fchksum-1.1.tar.gz"

HOMEPAGE="http://www.python.org http://www.azstarnet.com/~donut/programs/fchksum/"

SLOT="0"
LICENSE="PYTHON"
KEYWORDS="x86 sparc"

DEPEND=">=sys-devel/autoconf-2.13
	>=sys-libs/zlib-1.1.4
	readline? ( >=sys-libs/readline-4.1
		>=sys-libs/ncurses-5.2 )"

# spython can't provide python anymore, since it is missing important services like crypt.
# upgrades from spython to python can cause things like mailman's authentication system to break.
#PROVIDE="virtual/python"
# This means we also need to remove the /usr/bin/python symlink.

src_unpack() {

	unpack BeOpen-Python-2.0.tar.bz2
	cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo.diff
	autoconf

	cd ${S}/Modules

	cp -a ${FILESDIR}/pfconfig.h .
	unpack python-fchksum-1.1.tar.gz

	echo '*static*' >> Setup.local

	echo "zlib zlibmodule.c -lz" >> Setup.local
	if [ "`use readline`" ]
	then
		echo "readline readline.c -lreadline -lncurses" >> Setup.local
	fi

	echo "fchksum fchksum.c md5_2.c" >> Setup.local

	cd python-fchksum-1.1
	cp -a md5.h ../md5_2.h
	sed -e 's:"md5.h":"md5_2.h":' md5.c > ../md5_2.c
	sed -e 's:"md5.h":"md5_2.h":' fchksum.c > ../fchksum.c

}

src_compile() {

	export LDFLAGS=-static

	./configure --prefix=/usr --without-libdb || die

	#libdb3 support is available from http://pybsddb.sourceforge.net/; the one
	#included with python is for db 1.85 only.

	cp Makefile Makefile.orig
	sed -e "s:-g -O2:${CFLAGS}:" Makefile.orig > Makefile
	cd ${S}/Modules
	cp Makefile.pre Makefile.orig
	sed -e "s:MODOBJS=:MODOBJS=fchksum.o md5_2.o:" \
	Makefile.orig > Makefile.pre

	# Parallel make does not work
	cd ${S}
	make || die

}

src_install() {
	dodir /usr/share/man
	make install prefix=${D}/usr MANDIR=${D}/usr/share/man || die

	rm -rf ${D}/usr/include
	rm -rf ${D}/usr/lib/${PN}${PV}/config

	dodir /usr/lib/python${PV}/site-packages
	rm -rf ${D}/usr/lib/spython${PV}/site-packages
	dosym ../python${PV}/site-packages /usr/lib/spython${PV}/site-packages

	if [ "`use build`" ]
	then
		rm -rf ${D}/usr/share/man
		rm -rf ${D}/usr/include
		cd ${D}/usr/lib/spython2.0
		#remove test and lib-tk directory; we can do much more cleaning too.
		rm -rf test lib-tk
		#clean out byte-compiled stuff.	They aren't required, and doing so saves space
		#cd to root so "find" works properly.
		cd ${D}
		local x
		for x in `find -iname '*.py[co]'`
		do
			rm x
		done
	fi
}

pkg_preinst() {
	# keep portage from breaking from this move
	for file in ${ROOT}/usr/lib/python2.0/{xpak,portage}.py
	do
		[ -f ${file} ] || continue
		cp -a ${file} ${ROOT}/usr/lib/python2.0/site-packages
		rm -f ${file}*	#remove .pyc stuff too
	done
}
