# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/im-sdk/im-sdk-12.0.1_pre1891.ebuild,v 1.1 2004/09/13 20:10:16 usata Exp $

inherit iiimf

IUSE=""

DESCRIPTION="Internet/Intranet Input Method Framework; the next generation of input method framework"

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
