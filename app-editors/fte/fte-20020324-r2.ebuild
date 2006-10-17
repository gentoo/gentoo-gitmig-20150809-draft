# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/fte/fte-20020324-r2.ebuild,v 1.9 2006/10/17 22:07:12 gustavoz Exp $

inherit eutils

DESCRIPTION="Lightweight text-mode editor"
HOMEPAGE="http://fte.sourceforge.net"
SRC_URI="mirror://sourceforge/fte/${P}-src.zip
	mirror://sourceforge/fte/${P}-common.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc -sparc x86"
IUSE="gpm slang X"

RDEPEND=">=sys-libs/ncurses-5.2
	X? (
		|| (
			(
				x11-libs/libXdmcp
				x11-libs/libXau
				x11-libs/libX11
			)
		virtual/x11
		)
	)
	gpm? ( >=sys-libs/gpm-1.20 )"
DEPEND="${RDEPEND}
	slang? ( sys-libs/slang )
	app-arch/unzip"

set_targets() {
	export TARGETS=""
	use slang && TARGETS="$TARGETS sfte"
	use X && TARGETS="$TARGETS xfte"
	use gpm && TARGETS="$TARGETS vfte"
}

src_unpack() {
	unpack fte-20020324-src.zip
	unpack fte-20020324-common.zip

	mv fte fte-20020324

	cd ${S}

	epatch ${FILESDIR}/configpath.patch

	set_targets
	sed \
		-e "s:@targets@:${TARGETS}:" \
		-e "s:@cflags@:${CFLAGS}:" \
		-i src/fte-unix.mak
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
	einfo "Compiling configuration..."
	cd /usr/share/fte
	/usr/bin/cfte main.fte /etc/fte/system.fterc
}
