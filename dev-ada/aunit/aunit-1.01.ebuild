# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/aunit/aunit-1.01.ebuild,v 1.5 2006/05/12 14:09:09 george Exp $

IUSE=""

inherit gnat

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
	einfo "The envaironment has been set up to make gnat automatically find files for"
	einfo "Aunit. In order to immediately activate these settings please do:"
	einfo "env-update"
	einfo "source /etc/profile"
	einfo "Otherwise the settings will become active next time you login"
}
