# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lame/lame-3.96.ebuild,v 1.12 2004/07/28 17:04:09 agriffis Exp $

inherit flag-o-matic gcc eutils

DESCRIPTION="LAME Ain't an MP3 Encoder"
HOMEPAGE="http://lame.sourceforge.net"
SRC_URI="mirror://sourceforge/lame/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ~ia64 ~mips macos"
IUSE="gtk debug"

RDEPEND=">=sys-libs/ncurses-5.2
	gtk? ( =x11-libs/gtk+-1.2* )"

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	cd ${S} || die

	# If ccc (alpha compiler) is installed on the system, the default
	# configure is broken, fix it to respect CC.  This is only
	# directly broken for ARCH=alpha but would affect anybody with a
	# ccc binary in their PATH.  Bug #41908  (26 Jul 2004 agriffis)
	epatch ${FILESDIR}/lame-3.96-ccc.patch
	autoconf || die
}

src_compile() {
	# take out -fomit-frame-pointer from CFLAGS if k6-2
	is-flag "-march=k6-3" && filter-flags "-fomit-frame-pointer"
	is-flag "-march=k6-2" && filter-flags "-fomit-frame-pointer"
	is-flag "-march=k6" && filter-flags "-fomit-frame-pointer"

	[ "`gcc-fullversion`" == "3.3.2" ] && replace-flags -march=2.0 -march=1.0

	local myconf=""
	if use gtk; then
		myconf="${myconf} --enable-mp3x"
	fi

	# as of 3.95.1 changed from "yes" to "norm" ("alot" is also accepted)
	use debug \
		&& myconf="${myconf} --enable-debug=norm" \
		|| myconf="${myconf} --enable-debug=no"

	# The user sets compiler optimizations... But if you'd like
	# lame to choose it's own... uncomment one of these (experiMENTAL)
	# myconf="${myconf} --enable-expopt=full \
	# myconf="${myconf} --enable-expopt=norm \

	econf \
		--enable-shared \
		--enable-nasm \
		--enable-mp3rtp \
		${myconf} || die

	# Parallel make isn't happy
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} pkghtmldir=/usr/share/doc/${PF}/html install || die

	dodoc API ChangeLog HACKING PRESETS.draft README* STYLEGUIDE TODO USAGE
	dohtml misc/lameGUI.html Dll/LameDLLInterface.htm

	dobin ${S}/misc/mlame
}
