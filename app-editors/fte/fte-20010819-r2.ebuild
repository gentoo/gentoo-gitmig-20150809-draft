# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/fte/fte-20010819-r2.ebuild,v 1.15 2003/09/05 01:56:28 msterret Exp $

inherit eutils

IUSE="gpm slang X"

S=${WORKDIR}/${P}
DESCRIPTION="Lightweight text-mode editor"
HOMEPAGE="http://fte.sourceforge.net"
SRC_URI="mirror://sourceforge/fte/fte-20010819-src.zip
	mirror://sourceforge/fte/fte-20010819-common.zip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

RDEPEND=">=sys-libs/ncurses-5.2
	gpm? ( >=sys-libs/gpm-1.20 )"

DEPEND="app-arch/unzip
	slang? ( sys-libs/slang )
	${RDEPEND}"

TARGETS=""

if [ "`use slang`" ] ; then
	TARGETS="$TARGETS sfte"
fi

if [ "`use X`" ] ; then
	TARGETS="$TARGETS xfte"
fi

if [ "`use gpm`" ] ; then
	TARGETS="$TARGETS vfte"
fi

src_unpack() {

	cd ${WORKDIR}
	unpack fte-20010819-src.zip
	unpack fte-20010819-common.zip

	mv fte fte-20010819

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff

	cp src/fte-unix.mak src/fte-unix.mak.orig

	sed \
		-e "s:@targets@:${TARGETS}:" \
		-e "s:@cflags@:${CFLAGS}:" \
	src/fte-unix.mak.orig > src/fte-unix.mak
}

src_compile() {
	emake all || die

	cd config
	../src/cfte main.fte ../src/system.fterc
}

src_install () {
	local files
	into /usr

	files="${TARGETS} cfte compkeys"

	for i in ${files} ; do
		dobin src/$i ;
	done

	dodoc Artistic CHANGES BUGS COPYING HISTORY README TODO

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

