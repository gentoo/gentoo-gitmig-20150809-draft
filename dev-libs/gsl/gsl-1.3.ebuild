# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gsl/gsl-1.3.ebuild,v 1.2 2003/06/14 02:18:19 george Exp $

IUSE=""

inherit flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="The GNU Scientific Library"
SRC_URI="http://mirrors.rcn.net/pub/sourceware/gsl/${P}.tar.gz"
HOMEPAGE="http://sources.redhat.com/gsl/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

DEPEND="virtual/glibc"

replace-flags k6-3 i586
replace-flags k6-2 i586
replace-flags k6 i586
filter-flags -ffast-math


src_compile() {
	#Avoid locking (can break parallel builds)
 	local myconf
 	myconf="--disable-libtool-lock"

	econf ${myconf} || die
	emake || die

	#Uncomment the 'make check ...' line if you want to run the test suite.
	#Note that the check.log file will be several megabytes in size.
	#make check > ${WORKDIR}/check.log 2>&1 || die

}

src_install () {

	einstall || die
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS TODO THANKS

}
