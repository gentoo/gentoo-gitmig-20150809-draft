# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kimera/kimera-1.32.ebuild,v 1.4 2008/07/27 19:44:54 carlo Exp $

EAPI=1

inherit qt3

IUSE="anthy"

DESCRIPTION="A Japanese input method which supports the XIM protocol"
SRC_URI="mirror://sourceforge.jp/kimera/19749/${P}.tar.gz"
HOMEPAGE="http://kimera.sourceforge.jp/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"

DEPEND="x11-libs/qt:3
	anthy? ( app-i18n/anthy )
	!anthy? ( app-i18n/canna )"

src_compile(){
	local myconf
	if ! use anthy ; then
		myconf="no_anthy=1"
	fi

	${QTDIR}/bin/qmake ${myconf} kimera.pro || die

	# Avoid pre-stripping
	sed -i -e '/strip/d' Makefile

	emake || die
}

src_install(){
	emake INSTALL_ROOT="${D}" install || die

	dodoc AUTHORS INSTALL README*
}
