# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-utils/bluez-utils-2.1.ebuild,v 1.3 2003/05/09 16:16:54 latexer Exp $

DESCRIPTION="bluetooth utilities"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="sys-devel/bison
		sys-devel/flex
		>=net-wireless/bluez-libs-2.2"
RDEPEND=">=net-wireless/bluez-libs-2.2"
S="${WORKDIR}/${P}"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	# rfcomm needs some devices created to function properly
	C=0
	while [ $C -lt 16 ]; do
		if [ ! -c /dev/rfcomm$C ]; then
			mknod -m 666 /dev/rfcomm$C c 216 $C
		fi
		C=`expr $C + 1`
	done
}
