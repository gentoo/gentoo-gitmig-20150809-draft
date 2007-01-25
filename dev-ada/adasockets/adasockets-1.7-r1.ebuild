# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/adasockets/adasockets-1.7-r1.ebuild,v 1.14 2007/01/25 23:37:08 genone Exp $

DESCRIPTION="An Interface to BSD sockets from Ada (TCP, UDP and multicast)."
SRC_URI="http://www.rfc1149.net/download/adasockets/${P}.tar.gz"
HOMEPAGE="http://www.rfc1149.net/devel/adasockets/"
LICENSE="GMGPL"

DEPEND="<dev-lang/gnat-3.41
	>=sys-apps/sed-4"
RDEPEND=""
SLOT="0"
IUSE=""
KEYWORDS="x86 ppc"

src_compile() {
	econf --libdir=/usr/lib/ada/adalib \
		--includedir=/usr/lib/ada/adainclude || die "./configure failed"
	sed -i -e "s|-I\$libdir|-I/usr/lib/ada/adainclude|" src/adasockets-config.in

	emake || die
}

src_install () {
	cd ${S}
	#doins copies symlinks as regular files, resorting to manual cp
	dodir /usr/lib/ada/adalib/adasockets
	cp -d src/.libs/lib*.so* ${D}/usr/lib/ada/adalib/adasockets
	chmod 0755 ${D}/usr/lib/ada/adalib/adasockets/lib*.so*
	dosym /usr/lib/ada/adalib/adasockets/libadasockets.so /usr/lib
	dosym /usr/lib/ada/adalib/adasockets/libadasockets.so.0 /usr/lib
	dosym /usr/lib/ada/adalib/adasockets/libadasockets.so.0.0.0 /usr/lib
	insinto /usr/lib/ada/adalib/adasockets
	doins src/.libs/lib*.a
	chmod 0644 ${D}/usr/lib/ada/adalib/adasockets/lib*.a
	doins src/sockets*.ali

	insinto /usr/lib/ada/adainclude/adasockets
	doins src/sockets*.ads

	dodoc AUTHORS COPYING INSTALL NEWS README
	dodoc doc/adasockets.pdf doc/adasockets.ps
	doinfo doc/adasockets.info
	doman man/adasockets-config.1
	dobin src/adasockets-config

	#set up environment
	dodir /etc/env.d
	echo "ADA_OBJECTS_PATH=/usr/lib/ada/adalib/${PN}" \
		> ${D}/etc/env.d/55adasockets
	echo "ADA_INCLUDE_PATH=/usr/lib/ada/adainclude/${PN}" \
		>> ${D}/etc/env.d/55adasockets
}

pkg_postinst() {
	elog "The environment has been set up to make gnat automatically find files for"
	elog "AdaSockets. In order to immediately activate these settings please do:"
	elog "env-update"
	elog "source /etc/profile"
	elog "Otherwise the settings will become active next time you login"
}
