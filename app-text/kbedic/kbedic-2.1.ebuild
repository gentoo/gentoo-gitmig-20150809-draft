# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Ilian Zarov <coder@descom.com>
# Maintainer: Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/kbedic/kbedic-2.1.ebuild,v 1.1 2002/01/23 21:04:26 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
use kde && inherit kde

S=${WORKDIR}/${P}
DESCRIPTION="English <-> Bulgarian Dictionary"
SRC_URI="http://kbedic.search.bg/download/${P}.tar.gz
	 http://ftp1.sourceforge.net/kbedic/${P}.tar.gz"
HOMEPAGE="http://kbedic.sourceforge.net"

if [ "`use kde`" ]
then
    need-kde 2
else
    DEPEND=">=x11-libs/qt-2.3.1"
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
