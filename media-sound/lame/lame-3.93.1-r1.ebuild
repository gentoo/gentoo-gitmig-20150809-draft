# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lame/lame-3.93.1-r1.ebuild,v 1.17 2004/07/28 17:04:09 agriffis Exp $

inherit flag-o-matic gcc

DESCRIPTION="LAME Ain't an MP3 Encoder"
HOMEPAGE="http://www.mp3dev.org/mp3/"
SRC_URI="mirror://sourceforge/lame/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64"
IUSE="gtk debug"

RDEPEND=">=sys-libs/ncurses-5.2
	gtk? ( =x11-libs/gtk+-1.2* )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

src_unpack() {
	unpack ${A}

	# fix gtk detection
	sed -i -e "s:gtk12-config:gtk-config:" ${S}/configure
}

# this release completely removed oggvorbis support as it was too outdated.
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

	use debug \
		&& myconf="${myconf} --enable-debug=yes" \
		|| myconf="${myconf} --enable-debug=no"

	econf \
		--enable-shared \
		--enable-nasm \
		--enable-mp3rtp \
		--enable-extopt=full \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} pkghtmldir=${D}/usr/share/doc/${PF}/html install || die

	dodoc API COPYING HACKING PRESETS.draft LICENSE README* TODO USAGE
	dohtml misc/lameGUI.html Dll/LameDLLInterface.htm
}
