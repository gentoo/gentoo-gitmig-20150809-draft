# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/fte/fte-20020324-r1.ebuild,v 1.7 2004/10/05 12:19:43 pvdabeel Exp $

DESCRIPTION="Lightweight text-mode editor"
HOMEPAGE="http://fte.sourceforge.net"
SRC_URI="mirror://sourceforge/fte/${P}-src.zip
	mirror://sourceforge/fte/${P}-common.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
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

	cd ${WORKDIR}
	unpack fte-20020324-src.zip
	unpack fte-20020324-common.zip

	mv fte fte-20020324

	cd ${S}

	cp src/fte-unix.mak src/fte-unix.mak.orig

	set_targets
	sed \
		-e "s:@targets@:${TARGETS}:" \
		-e "s:@cflags@:${CFLAGS}:" \
		src/fte-unix.mak.orig  > src/fte-unix.mak
}

src_compile() {
	DEFFLAGS="PREFIX=/usr CONFIGDIR=/usr/share/fte \
		DEFAULT_FTE_CONFIG=../config/main.fte OPTIMIZE="

	set_targets
	emake $DEFFLAGS TARGETS="${TARGETS}" all || die

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

	dobin ${FILESDIR}/fte

	dodoc Artistic CHANGES BUGS HISTORY README TODO

	dodir etc/fte
	cp src/system.fterc ${D}/etc/fte/system.fterc

	dodir usr/share/doc/${P}/html
	cp doc/INDEX doc/*.html ${D}/usr/share/doc/${P}/html

#	if [ -a ${D}/usr/bin/xfte ] ; then
#		into /usr/X11R6 ;
#		dobin src/xfte ;
#		rm ${D}/usr/bin/xfte ;
#	fi

	dodir usr/share/fte
	cp -R config/* ${D}/usr/share/fte
	rm -rf ${D}/usr/share/fte/CVS
}
