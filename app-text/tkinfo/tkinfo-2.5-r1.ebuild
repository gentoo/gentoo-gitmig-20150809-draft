# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/tkinfo/tkinfo-2.5-r1.ebuild,v 1.5 2002/08/02 17:42:50 phoenix Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Info Browser in TK"
SRC_URI="http://math-www.uni-paderborn.de/~axel/tkinfo/${P}.tar.gz"
HOMEPAGE="http://math-www.uni-paderborn.de/~axel/tkinfo/"
KEYWORDS="x86"
SLOT="0"
LICENSE="freedist"

DEPEND=">=dev-lang/tk-8.0.5"


src_install () {

    dobin tkinfo
    doman tkinfo.1
    dodoc README

}

pkg_postinst () {

# Let's check to see if info has been setup completely
cd /usr/share/info
if [ -f dir ]; then
	exit 0;
else
	mkinfodir . > dir
fi
}

