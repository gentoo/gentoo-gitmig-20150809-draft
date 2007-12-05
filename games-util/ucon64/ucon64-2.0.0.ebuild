# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/ucon64/ucon64-2.0.0.ebuild,v 1.6 2007/12/05 03:33:38 mr_bones_ Exp $

DESCRIPTION="The backup tool and wonderful emulator's Swiss Army knife program"
HOMEPAGE="http://ucon64.sourceforge.net/"
SRC_URI="mirror://sourceforge/ucon64/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="sys-libs/zlib"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^CFLAGS/s/-O3/${CFLAGS}/" \
		-e "/^LDFLAGS/s/-s$/${LDFLAGS}/" \
		src/{,libdiscmage/}Makefile.in || die "sed failed"
}

src_compile() {
	local myconf

	if [[ ! -e /usr/include/sys/io.h ]] ; then
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
	elog "In order to use ${PN}, please create the directory ~/.ucon64/dat"
	elog "The command to do that is:"
	elog "    mkdir -p ~/.ucon64/dat"
	elog "Then, you can copy your DAT file collection to ~/.ucon64/dat"
	elog
	elog "To enable Discmage support, cp /usr/lib/discmage.so to ~/.ucon64"
	elog "The command to do that is:"
	elog "    cp /usr/lib/discmage.so ~/.ucon64/"
	elog
	elog "Be sure to check ~/.ucon64rc for some options after"
	elog "you've run uCON64 for the first time"
}
