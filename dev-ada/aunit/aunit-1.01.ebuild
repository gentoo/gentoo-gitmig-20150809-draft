# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/aunit/aunit-1.01.ebuild,v 1.7 2007/01/25 23:44:27 genone Exp $

IUSE=""

DESCRIPTION="Aunit, Ada unit testing framework"
SRC_URI="http://libre.act-europe.fr/aunit/aunit-1.01.tar.gz"

HOMEPAGE="http://libre.act-europe.fr/aunit/"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DEPEND=">=dev-lang/gnat-3.14p"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	#makefile does not do much, so we need to install stuff manually
	dodir /usr/lib/ada/adainclude/${PN}
	chmod -x aunit/framework/text_reporter/*
	cp aunit/framework/*.ad? aunit/text_reporter/*.ad? \
		${D}/usr/lib/ada/adainclude/${PN}

	# Install documentation.
	dodoc COPYING AUnit.html

	dodir /usr/share/${PN}
	cp -r template test ${D}/usr/share/${PN}

	#set up environment
	dodir /etc/env.d
	echo "ADA_INCLUDE_PATH=/usr/lib/ada/adainclude/${PN}" \
		> ${D}/etc/env.d/55aunit
}

pkg_postinst(){
	elog "The environment has been set up to make gnat automatically find files for"
	elog "Aunit. In order to immediately activate these settings please do:"
	elog "env-update"
	elog "source /etc/profile"
	elog "Otherwise the settings will become active next time you login"
}
