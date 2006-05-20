# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kimera/kimera-1.32.ebuild,v 1.1 2006/05/20 09:30:14 matsuu Exp $

inherit kde-functions

IUSE="anthy"

DESCRIPTION="A Japanese input method which supports the XIM protocol"
SRC_URI="mirror://sourceforge.jp/kimera/19749/${P}.tar.gz"
HOMEPAGE="http://kimera.sourceforge.jp/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DEPEND="anthy? ( app-i18n/anthy )
	!anthy? ( app-i18n/canna )"
need-qt 3

src_compile(){
	local myconf
	if ! use anthy ; then
		myconf="no_anthy=1"
	fi

	qmake ${myconf} kimera.pro || die
	emake || die
}

src_install(){
	make INSTALL_ROOT="${D}" install || die

	dodoc AUTHORS INSTALL README*
}
