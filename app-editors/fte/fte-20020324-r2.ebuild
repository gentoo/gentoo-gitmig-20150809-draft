# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/fte/fte-20020324-r2.ebuild,v 1.1 2004/03/17 14:32:49 phosphan Exp $

inherit eutils

IUSE="gpm slang X"

DESCRIPTION="Lightweight text-mode editor"
SRC_URI="mirror://sourceforge/fte/${P}-src.zip
	mirror://sourceforge/fte/${P}-common.zip"
HOMEPAGE="http://fte.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

RDEPEND=">=sys-libs/ncurses-5.2
	gpm? ( >=sys-libs/gpm-1.20 )"

DEPEND="${RDEPEND}
	slang? ( sys-libs/slang )
	app-arch/unzip
	X? ( virtual/x11 )"

TARGETS=""

if [ "`use slang`" ] ; then
	TARGETS="${TARGETS} sfte"
fi

if [ "`use X`" ] ; then
	TARGETS="${TARGETS} xfte"
fi

if [ "`use gpm`" ] ; then
	TARGETS="${TARGETS} vfte"
fi

src_unpack() {

	cd ${WORKDIR}
	unpack fte-20020324-src.zip
	unpack fte-20020324-common.zip

	mv fte fte-20020324

	cd ${S}

	epatch ${FILESDIR}/configpath.patch

	sed \
		-e "s:@targets@:${TARGETS}:" \
		-e "s:@cflags@:${CFLAGS}:" \
		-i src/fte-unix.mak
}

src_compile() {
	DEFFLAGS="PREFIX=/usr CONFIGDIR=/usr/share/fte \
		DEFAULT_FTE_CONFIG=../config/main.fte OPTIMIZE="

	emake $DEFFLAGS TARGETS="$TARGETS" all || die
}

src_install () {
	local files
	into /usr

	files="${TARGETS} cfte compkeys"

	for i in ${files} ; do
		dobin src/$i ;
	done

	dobin ${FILESDIR}/fte

	dodoc Artistic CHANGES BUGS COPYING HISTORY README TODO

	keepdir etc/fte

	dodir usr/share/doc/${P}/html
	cp doc/INDEX doc/*.html ${D}/usr/share/doc/${P}/html

	dodir usr/share/fte
	cp -R config/* ${D}/usr/share/fte
	rm -rf ${D}/usr/share/fte/CVS
}

pkg_postinst() {
	einfo "Compiling configuration..."
	cd /usr/share/fte
	/usr/bin/cfte main.fte /etc/fte/system.fterc
}
