# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbedic/kbedic-3.1.ebuild,v 1.5 2003/09/05 22:37:22 msterret Exp $
inherit kde

S=${WORKDIR}/${P}
DESCRIPTION="English <-> Bulgarian Dictionary"
SRC_URI="mirror://sourceforge/kbedic/$P.tar.gz"
HOMEPAGE="http://kbedic.sourceforge.net"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="kde"

need-qt 3
[ -n "`use kde`" ] && need-kde 3

# -gcc3 is a typical "default value present in both definition and declaration" fix.
# -location makes it isntall the dictionary datafiles in /usr/share/kbedic,
# and not directly in /usr/share. Both sent upstream.
PATCHES="$FILESDIR/$P-gcc3.diff $FILESDIR/$P-location.diff"

src_compile() {

	local myopts
	if [ -n "`use kde`" ]
	then
		myopts="--with-kde"
		set-kdedir 3
	fi

	need-automake 1.6
	need-autoconf 2.5

	aclocal

	./configure --prefix=/usr \
		--host=${CHOST} \
		${myopts} || die

	emake || die

}

