# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-devel/automake/automake-1.5d-r2.ebuild,v 1.7 2002/08/14 11:56:44 murphy Exp $

OLD_PV=1.4-p5
OLD_P=${PN}-${OLD_PV}
S=${WORKDIR}/${P}
OLD_S=${WORKDIR}/${OLD_P}
DESCRIPTION="Used to generate Makefile.in from Makefile.am"
SRC_URI="ftp://sources.redhat.com/pub/${PN}/${P}.tar.bz2
	ftp://ftp.gnu.org/gnu/${PN}/${OLD_P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/automake/automake.html"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="sys-devel/perl
	>=sys-devel/autoconf-2.52-r1"
		
SLOT="1.5"

src_compile() {

	#
	# ************ automake-1.5x ************
	#

	# stupid configure script goes and run autoconf in a subdir,
	# so 'ac-wrapper.pl' do not detect that it should use
	# autoconf-2.5x
	export WANT_AUTOCONF_2_5=1
	
	cd ${S}

	cp automake.texi automake.texi.orig
	sed -e "s:setfilename automake.info:setfilename automake-1.5.info:" \
		automake.texi.orig >automake.texi
	
	./configure --prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--target=${CHOST} || die
	
	emake ${MAKEOPTS} || die

	unset WANT_AUTOCONF_2_5

	#
	# ************ automake-1.4-p5 ************
	#
	cd ${OLD_S}
	./configure --prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--target=${CHOST} || die
		
	emake ${MAKEOPTS} || die
}

src_install() {

	# install wrapper script for autodetecting the proper version
	# to use.
	exeinto /usr/lib/${PN}
	newexe ${FILESDIR}/am-wrapper.pl-1.5 am-wrapper.pl
	dosed "s:1\.5x:${PV}:g" /usr/lib/${PN}/am-wrapper.pl

	#
	# ************ automake-1.5x ************
	#

	cd ${S}
	make DESTDIR=${D} \
		install || die

	for x in automake aclocal
	do
		mv ${D}/usr/bin/${x}-${PV} ${D}/usr/bin/${x}-${PV}
		rm -f ${D}/usr/bin/${x}
	done

	doinfo automake-1.5.info*

	docinto ${PV}
	dodoc COPYING NEWS README THANKS TODO AUTHORS ChangeLog

	#
	# ************ automake-1.4-p5 ************
	#

    cd ${OLD_S}
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	for x in automake aclocal
	do
		mv ${D}/usr/bin/${x} ${D}/usr/bin/${x}-1.4
		dosym ../lib/${PN}/am-wrapper.pl /usr/bin/${x}
	done

	docinto ${OLD_PV}
	dodoc COPYING NEWS README THANKS TODO AUTHORS ChangeLog
}

pkg_preinst() {
	
	# remove these to make sure symlinks install properly if old versions
	# was binaries
	for x in automake aclocal
	do
		if [ -e /usr/bin/${x} ]
		then
			rm -f /usr/bin/${x}
		fi
	done
}

