# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/im-sdk/im-sdk-12.1_p2002.ebuild,v 1.1 2005/03/30 17:24:46 usata Exp $

inherit iiimf

IUSE=""

DESCRIPTION="Internet/Intranet Input Method Framework; the next generation of input method framework"
SRC_URI="http://www.openi18n.org/download/im-sdk/src/${IMSDK_P}.tar.bz2"

LICENSE="MIT X11 IBM"

KEYWORDS="~x86"
DEPEND="=dev-libs/eimil-${PV}
	=dev-libs/libiiimcf-${PV}
	=dev-libs/libiiimp-${PV}
	=app-i18n/iiimcf-${PV}
	=app-i18n/iiimsf-${PV}
	=app-i18n/leif-${PV}"
RDEPEND="${DEPEND}
	=dev-libs/csconv-${PV}"

S="${WORKDIR}/${IMSDK}"

src_compile() {

	return
}

src_install() {

	dodoc ChangeLog README
	dohtml -r doc/*
}
