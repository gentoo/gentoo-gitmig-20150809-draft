# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/colortail/colortail-0.3.0-r3.ebuild,v 1.8 2004/02/09 07:31:55 absinthe Exp $

DESCRIPTION="Colortail custom colors your log files and works like tail"
SRC_URI="http://www.student.hk-r.se/~pt98jan/colortail-0.3.0.tar.gz"
HOMEPAGE="http://www.student.hk-r.se/~pt98jan/colortail.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64"

src_unpack() {
	unpack ${A}
	cd ${S}

	# 2002-09-08: karltk
	# This bit of trickery conditionally applies the gcc-3.2 patch
	# if the desired compiler is not the 2.95.x series. It is assumed
	# that if it's not 2.95, it is 3.0.x or newer.
	[ -z "${CXX}" ] && CXX=g++
	if [ "`${CXX} -dumpversion | cut -d. -f1,2`" != "2.95" ] ; then
		# Both 3.1.x and 3.2 work with the patch.
		patch -p1 < ${FILESDIR}/${PV}/ansi-c++-gcc-3.2.diff || die
	fi
	${CXX} -dumpversion > .gentoo-compiler-version
}

src_compile() {
	[ -z "${CXX}" ] && CXX=g++
	if [ "`cat .gentoo-compiler-version`" != "`${CXX} -dumpversion`" ] ; then
		eerror "You must unpack and compile with the same CXX setting"
		die
	fi
	econf
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README example-conf/conf*
	dodir /usr/bin/wrappers
	dosym /usr/bin/colortail /usr/bin/wrappers/tail
}

pkg_postinst() {
	einfo
	if grep /usr/bin/wrappers /etc/profile > /dev/null
	then
		einfo "/etc/profile already updated for wrappers"
	else
		einfo "Add this to the end of your ${ROOT}etc/profile:"
		einfo
		einfo "#Put /usr/bin/wrappers in path before /usr/bin"
		einfo 'export PATH=/usr/bin/wrappers:${PATH}'
	fi
	einfo
}
