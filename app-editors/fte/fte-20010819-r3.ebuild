# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/fte/fte-20010819-r3.ebuild,v 1.17 2004/05/31 22:12:03 vapier Exp $

inherit eutils

DESCRIPTION="Lightweight text-mode editor"
HOMEPAGE="http://fte.sourceforge.net"
SRC_URI="mirror://sourceforge/fte/${P}-src.zip
	mirror://sourceforge/fte/${P}-common.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE="gpm slang X"

RDEPEND=">=sys-libs/ncurses-5.2
	gpm? ( >=sys-libs/gpm-1.20 )"
DEPEND="${RDEPEND}
	slang? ( sys-libs/slang )
	app-arch/unzip
	X? ( virtual/x11 )"

set_targets() {
	export TARGETS=""
	use slang && TARGETS="$TARGETS sfte"
	use X && TARGETS="$TARGETS xfte"
	use gpm && TARGETS="$TARGETS vfte"
}

src_unpack() {
	unpack fte-20010819-src.zip
	unpack fte-20010819-common.zip

	mv fte fte-20010819

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff

	set_targets
	sed -i -e "s:@targets@:${TARGETS}:" \
		-e "s:@cflags@:${CFLAGS}:" \
		src/fte-unix.mak
}

src_compile() {
	emake all || die

	cd config
	../src/cfte main.fte ../src/system.fterc
}

src_install() {
	local files
	into /usr

	set_targets
	files="${TARGETS} cfte compkeys"

	for i in ${files} ; do
		dobin src/$i ;
	done

	dodoc Artistic CHANGES BUGS HISTORY README TODO

	dodir etc/fte
	cp src/system.fterc ${D}/etc/fte/system.fterc

	dodir usr/share/doc/${P}/html
	cp doc/INDEX doc/*.html ${D}/usr/share/doc/${P}/html

	dodir usr/share/fte
	cp -R config/* ${D}/usr/share/fte
	rm -rf ${D}/usr/share/fte/CVS
}
