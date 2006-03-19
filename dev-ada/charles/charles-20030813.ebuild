# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/charles/charles-20030813.ebuild,v 1.5 2006/03/19 19:09:36 halcy0n Exp $

IUSE=""

inherit gnat

DESCRIPTION="Charles Container Library for Ada"
SRC_URI="http://home.earthlink.net/~matthewjheaney/charles/${P}.zip
	http://home.earthlink.net/~matthewjheaney/charles/charles.pdf
	http://home.earthlink.net/~matthewjheaney/charles/charles-ae2003.pdf
	http://home.earthlink.net/~matthewjheaney/charles/charlesppt.pdf"

HOMEPAGE="http://home.earthlink.net/~matthewjheaney/charles/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
SLOT="0"

RDEPEND=">=dev-lang/gnat-3.14p"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	mkdir -p ${S}
	cd ${S}
	unpack ${P}.zip
}

src_install () {
	#makefile does not do much, so we need to install stuff manually
	dodir /usr/lib/ada/adainclude/${PN}
	cp *.ad? ${D}/usr/lib/ada/adainclude/${PN}

	# Install documentation.
	mv COPYING.TXT COPYING
	dodoc COPYING
	insinto /usr/share/doc/${P}
	doins ${DISTDIR}/charles.pdf ${DISTDIR}/charles-ae2003.pdf \
		${DISTDIR}/charlesppt.pdf

	dodir /usr/share/${PN}
	cp -r examples ${D}/usr/share/${PN}

	#set up environment
	dodir /etc/env.d
	echo "ADA_INCLUDE_PATH=/usr/lib/ada/adainclude/${PN}" \
		> ${D}/etc/env.d/55charles
}

pkg_postinst(){
	einfo "The envaironment has been set up to make gnat automatically find files for"
	einfo "Charles Container Library. In order to immediately activate these settings"
	einfo "please do:"
	einfo "env-update"
	einfo "source /etc/profile"
	einfo "Otherwise the settings will become active next time you login"
}
