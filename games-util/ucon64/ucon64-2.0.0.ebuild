# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/ucon64/ucon64-2.0.0.ebuild,v 1.1 2005/08/23 17:15:46 mr_bones_ Exp $

DESCRIPTION="The backup tool and wonderful emulator's Swiss Army knife program"
HOMEPAGE="http://ucon64.sourceforge.net/"
SRC_URI="mirror://sourceforge/ucon64/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="sys-libs/zlib"

S=${WORKDIR}/${P}-src

src_compile() {
	local myconf

	if [ ! -e /usr/include/sys/io.h ]; then
		ewarn "Disabling support for parallel port"
		myconf="${myconf} --disable-parallel"
	fi

	cd src
	econf ${myconf} || die
	emake || die "emake failed"
}

src_install() {
	dobin src/ucon64 || die "dobin failed"
	dolib.so src/libdiscmage/discmage.so || die "dolib.so failed"
	dodoc GoodCodes.txt
	dohtml -x src -r -A png,jpg *
}

pkg_postinst() {
	echo
	einfo "In order to use ${PN}, please create the directory ~/.ucon64/dat"
	einfo "The command to do that is:"
	einfo "    mkdir -p ~/.ucon64/dat"
	einfo "Then, you can copy your DAT file collection to ~/.ucon64/dat"
	echo
	einfo "To enable Discmage support, cp /usr/lib/discmage.so to ~/.ucon64"
	einfo "The command to do that is:"
	einfo "    cp /usr/lib/discmage.so ~/.ucon64/"
	echo
	einfo "Be sure to check ~/.ucon64rc for some options after"
	einfo "you've run uCON64 for the first time"
}
