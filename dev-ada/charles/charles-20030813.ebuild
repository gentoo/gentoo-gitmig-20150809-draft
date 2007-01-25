# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/charles/charles-20030813.ebuild,v 1.8 2007/01/25 23:47:15 genone Exp $

IUSE=""

DESCRIPTION="Charles Container Library for Ada"
SRC_URI="http://home.earthlink.net/~matthewjheaney/charles/${P}.zip
	http://home.earthlink.net/~matthewjheaney/charles/charles.pdf
	http://home.earthlink.net/~matthewjheaney/charles/charles-ae2003.pdf
	http://home.earthlink.net/~matthewjheaney/charles/charlesppt.pdf"

HOMEPAGE="http://home.earthlink.net/~matthewjheaney/charles/"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

RDEPEND=">=dev-lang/gnat-3.14p"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	mkdir -p ${S}
	cd ${S}
	unpack ${P}.zip
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
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
	elog "The environment has been set up to make gnat automatically find files for"
	elog "Charles Container Library. In order to immediately activate these settings"
	elog "please do:"
	elog "env-update"
	elog "source /etc/profile"
	elog "Otherwise the settings will become active next time you login"
}
