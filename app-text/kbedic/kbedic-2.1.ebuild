# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/kbedic/kbedic-2.1.ebuild,v 1.5 2002/08/02 17:42:49 phoenix Exp $

use kde && inherit kde

S=${WORKDIR}/${P}
DESCRIPTION="English <-> Bulgarian Dictionary"
SRC_URI="http://kbedic.search.bg/download/${P}.tar.gz
	 http://ftp1.sourceforge.net/kbedic/${P}.tar.gz"
HOMEPAGE="http://kbedic.sourceforge.net"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

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
