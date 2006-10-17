# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/fte/fte-20050108-r3.ebuild,v 1.5 2006/10/17 22:07:12 gustavoz Exp $

inherit eutils

DESCRIPTION="Lightweight text-mode editor"
HOMEPAGE="http://fte.sourceforge.net"
SRC_URI="mirror://sourceforge/fte/${P}-src.zip
	mirror://sourceforge/fte/${P}-common.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc -sparc x86"
IUSE="gpm slang X"
S=${WORKDIR}/${PN}

RDEPEND="|| ( (
		x11-libs/libXdmcp
		x11-libs/libXau
		x11-libs/libX11
	) virtual/x11 )
	>=sys-libs/ncurses-5.2
	gpm? ( >=sys-libs/gpm-1.20 )"
DEPEND="${RDEPEND}
	slang? ( sys-libs/slang )
	app-arch/unzip"

set_targets() {
	export TARGETS=""
	use slang && TARGETS="$TARGETS sfte"
	use X && TARGETS="$TARGETS xfte"

	TARGETS="$TARGETS vfte"
}

src_unpack() {
	unpack ${P}-src.zip
	unpack ${P}-common.zip

	cd ${S}

	epatch ${FILESDIR}/fte-gcc34
	epatch ${FILESDIR}/${PN}-new_keyword.patch

	set_targets
	sed \
		-e "s:@targets@:${TARGETS}:" \
		-e "s:@cflags@:${CFLAGS}:" \
		-i src/fte-unix.mak

	if ! use gpm; then
		sed \
			-e "s:#define USE_GPM://#define USE_GPM:" \
			-i src/con_linux.cpp
		sed \
			-e "s:-lgpm::" \
			-i src/fte-unix.mak
	fi

	cat /usr/include/linux/keyboard.h \
		| grep -v "wait.h" \
		> src/hacked_keyboard.h

	sed \
		-e "s:<linux/keyboard.h>:\"hacked_keyboard.h\":" \
		-i src/con_linux.cpp
}

src_compile() {
	DEFFLAGS="PREFIX=/usr CONFIGDIR=/usr/share/fte \
		DEFAULT_FTE_CONFIG=../config/main.fte OPTIMIZE="

	set_targets
	emake $DEFFLAGS TARGETS="$TARGETS" all || die
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

	keepdir etc/fte

	dodir usr/share/doc/${P}/html
	cp doc/INDEX doc/*.html ${D}/usr/share/doc/${P}/html

	dodir usr/share/fte
	cp -R config/* ${D}/usr/share/fte
	rm -rf ${D}/usr/share/fte/CVS
}

pkg_postinst() {
	ebegin "Compiling configuration"
	cd /usr/share/fte
	/usr/bin/cfte main.fte /etc/fte/system.fterc
	eend $?
}
