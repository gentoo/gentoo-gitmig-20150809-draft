# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/dev86/dev86-0.16.17-r2.ebuild,v 1.1 2005/11/11 00:14:37 chrb Exp $

inherit eutils

DESCRIPTION="Bruce's C compiler - Simple C compiler to generate 8086 code"
HOMEPAGE="http://www.cix.co.uk/~mayday"
SRC_URI="http://www.cix.co.uk/~mayday/dev86/Dev86src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/libc
		dev-util/gperf"

src_unpack() {
	unpack "${A}"
	# elksemu doesn't compile under amd64
	if use amd64; then
		einfo "Not compiling elksemu on amd64"
		sed -i.orig \
			-e 's,alt-libs elksemu,alt-libs,' \
			-e 's,install-lib install-emu,install-lib,' \
			${S}/makefile.in
	fi
	cd ${S}
	epatch "${FILESDIR}/dev86-pic.patch"
	sed -i -e "s/-O2 -g/${CFLAGS}/" makefile.in
}

src_compile() {
	emake -j1 DIST="${D}" || die

	export PATH=${S}/bin:${PATH}
	cd bin
	ln -s ncc bcc
	cd ..
	cd bootblocks
	ln -s ../bcc/version.h .
	emake DIST="${D}" || die
}

src_install() {
	make install-all DIST="${D}" || die
	install -m 755 bootblocks/makeboot "${D}/usr/bin"
}
