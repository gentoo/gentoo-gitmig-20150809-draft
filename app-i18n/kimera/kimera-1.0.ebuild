# Copyright 1999-2005 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kimera/kimera-1.0.ebuild,v 1.1 2005/10/30 04:24:08 usata Exp $

inherit kde-functions
need-qt 3

IUSE=""

MY_P="${P/_}"
DESCRIPTION="A Japanese input server which supports the XIM protocol"
SRC_URI="mirror://sourceforge.jp/kimera/16937/${MY_P}.tar.gz"
HOMEPAGE="http://kimera.sourceforge.jp/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

S="${WORKDIR}/${P/_*}"

src_compile(){
	qmake kimera.pro || die
	emake || die
}

src_install(){
	make INSTALL_ROOT=${D} install || die

	dodoc AUTHORS INSTALL README
}
