# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/kconvert/kconvert-1.1.ebuild,v 1.7 2004/09/03 14:38:15 dholm Exp $
inherit kde-functions
need-qt 3

DESCRIPTION="Converting Toolbetween Metric and Imperial"
HOMEPAGE="http://apps.kde.com/na/2/counter/vid/5632/kcurl"
SRC_URI="http://ftp.kde.com/Math_Science/KConvert/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""

DEPEND=""
RDEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL README TODO
}
