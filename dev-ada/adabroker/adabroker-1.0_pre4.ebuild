# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/adabroker/adabroker-1.0_pre4.ebuild,v 1.2 2003/09/08 07:20:54 msterret Exp $

S="${WORKDIR}/${PN}-1.0pre4"
DESCRIPTION="AdaBroker is a CORBA implementation for Ada."
SRC_URI="http://adabroker.eu.org/distrib/${PN}-1.0pre4.tar.gz"
HOMEPAGE="http://adabroker.eu.org/"
LICENSE="GMGPL"

DEPEND="dev-ada/gnat"
RDEPEND=""
IUSE=""
SLOT="0"
KEYWORDS="~x86"

inherit gnat

src_compile() {
	econf \
		--libdir=/usr/lib/ada/adalib \
		--includedir=/usr/lib/ada/adainclude || die "./configure failed"

	sed -i -e "s|-I\$libdir|-I/usr/lib/ada/adainclude|" src/adabroker-config.in
	# We want to use the old version of adasockets provided by adabroker
	# and not the newer version in portage.
	sed -i -e "s|\`adasockets-config.--cflags\`||" \
		src/adabroker-config.in
	sed -i -e "s|\`adasockets-config.--libs\`|/usr/lib/ada/adalib/adabroker/libadasockets.a|" \
		src/adabroker-config.in

	emake || die
}

src_install () {
	make prefix=${D}/usr \
		libdir=${D}/usr/lib/ada/adalib/adabroker \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		includedir=${D}/usr/lib/ada/adainclude/adabroker install || die

	dodoc COPYING INSTALL NEWS README

	# Again, we try to fix GNAE compatibility
	mv ${D}/usr/lib/ada/adalib/adabroker/adabroker/*.ali \
		${D}/usr/lib/ada/adalib/adabroker/
	mv ${D}/usr/lib/ada/adalib/adabroker/adasockets/*.ali \
		${D}/usr/lib/ada/adalib/adabroker/

	dodir /usr/lib/ada/adainclude/adabroker
	mv ${D}/usr/lib/ada/adalib/adabroker/adabroker/* \
		${D}/usr/lib/ada/adainclude/adabroker/
	mv ${D}/usr/lib/ada/adalib/adabroker/adasockets/* \
		${D}/usr/lib/ada/adainclude/adabroker/

	rmdir ${D}/usr/lib/ada/adalib/adabroker/adabroker
	rmdir ${D}/usr/lib/ada/adalib/adabroker/adasockets
	# This is an old version of adasockets, we don't want it to overwrite
	# the version of adasockets in portage
	rm ${D}/usr/bin/adasockets-config

	dosym /usr/lib/ada/adalib/adabroker/libbroca.so /usr/lib
	dosym /usr/lib/ada/adalib/adabroker/libbroca.so.0 /usr/lib
	dosym /usr/lib/ada/adalib/adabroker/libbroca.so.0.0.0 /usr/lib
}
