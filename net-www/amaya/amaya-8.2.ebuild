# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/amaya/amaya-8.2.ebuild,v 1.3 2004/01/09 21:54:01 weeve Exp $

inherit libtool

S=${WORKDIR}/Amaya/LINUX-ELF

DESCRIPTION="The W3C Web-Browser"
SRC_URI="ftp://ftp.w3.org/pub/amaya/${PN}-src-${PV}.tgz
	 ftp://ftp.w3.org/pub/amaya/old/${PN}-src-${PV}.tgz"
HOMEPAGE="http://www.w3.org/Amaya/"

KEYWORDS="~x86 ~ppc ~sparc"
LICENSE="GPL-2"
SLOT="0"
IUSE="gtk"

RDEPEND="
	( gtk? =x11-libs/gtk+-1.2* : virtual/motif )
	( gtk? =dev-libs/glib-1.2* )
	gtk? ( media-libs/imlib )"

DEPEND="dev-lang/perl
	${RDEPEND}"

src_compile() {
	local myconf=""
	mkdir ${S}
	cd ${S}
	if [ -n "`use gtk`" ]
	then
	    myconf="${myconf} --with-gtk"

	else
	    myconf="${myconf} --without-gtk"
	fi
	../configure \
		${myconf} \
		--prefix=/usr \
		--host=${CHOST}
	make || die
}

src_install () {
	dodir /usr
	make prefix=${D}/usr install || die
	rm ${D}/usr/bin/amaya
	rm ${D}/usr/bin/print
	dosym /usr/Amaya/applis/bin/amaya /usr/bin/amaya
	dosym /usr/Amaya/applis/bin/print /usr/bin/print
}
