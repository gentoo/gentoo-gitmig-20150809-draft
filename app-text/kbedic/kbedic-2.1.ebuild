# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbedic/kbedic-2.1.ebuild,v 1.12 2003/09/05 22:37:22 msterret Exp $

use kde && inherit kde

S=${WORKDIR}/${P}
DESCRIPTION="English <-> Bulgarian Dictionary"
SRC_URI="http://kbedic.search.bg/download/${P}.tar.gz
	 mirror://sourceforge/kbedic/${P}.tar.gz"
HOMEPAGE="http://kbedic.sourceforge.net"
KEYWORDS="x86 sparc "
SLOT="0"
LICENSE="GPL-2"
IUSE="kde"

if [ "`use kde`" ]
then
	need-kde 2
else
	DEPEND="=x11-libs/qt-2.3*"
	RDEPEND="$DEPEND"
fi

src_unpack() {
	unpack ${A}
}

src_compile() {
	local myopts
	if [ -n "`use kde`" ]
	then
		myopts="--with-kde"
		set-kdedir
	fi
	./configure --prefix=/usr \
		--host=${CHOST} \
		${myopts} || die
	emake || die
}

src_install() {
	make \
		prefix=${D}/usr \
		install || die
}
