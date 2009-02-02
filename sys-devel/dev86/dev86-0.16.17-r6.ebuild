# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/dev86/dev86-0.16.17-r6.ebuild,v 1.1 2009/02/02 19:02:27 truedfx Exp $

inherit eutils

DESCRIPTION="Bruce's C compiler - Simple C compiler to generate 8086 code"
HOMEPAGE="http://www.cix.co.uk/~mayday"
SRC_URI="http://www.cix.co.uk/~mayday/dev86/Dev86src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-devel/bin86"
DEPEND="${RDEPEND}
	dev-util/gperf"

src_unpack() {
	unpack ${A}
	# elksemu doesn't compile under amd64
	if use amd64; then
		einfo "Not compiling elksemu on amd64"
		sed -i.orig \
			-e 's,alt-libs elksemu,alt-libs,' \
			-e 's,install-lib install-emu,install-lib,' \
			"${S}"/makefile.in
	fi
	cd "${S}"
	epatch "${FILESDIR}/dev86-pic.patch"
	epatch "${FILESDIR}"/${P}-fortify.patch
	sed -i -e "s/-O2 -g/${CFLAGS}/" \
		-e "s/INEXE=-m 755 -s/INEXE=-m 755/g" makefile.in
	sed -i -e "s/INSTALL_OPTS=-m 755 -s/INSTALL_OPTS=-m 755/g" bin86/Makefile
	sed -i -e "s/install -m 755 -s/install -m 755/g" dis88/Makefile
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
	dobin bootblocks/makeboot
	# remove all the stuff supplied by bin86
	cd "${D}"
	rm usr/bin/{as,ld,nm,objdump,size}86
	rm usr/man/man1/{as,ld}86.1
	mkdir -p usr/share/man
	mv usr/man usr/share/
}
