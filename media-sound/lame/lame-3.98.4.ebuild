# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lame/lame-3.98.4.ebuild,v 1.2 2010/08/23 19:54:34 ssuominen Exp $

EAPI=2
inherit autotools eutils flag-o-matic toolchain-funcs versionator

DESCRIPTION="LAME Ain't an MP3 Encoder"
HOMEPAGE="http://lame.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="debug mmx mp3rtp sndfile static-libs"

RDEPEND=">=sys-libs/ncurses-5.2
	sndfile? ( >=media-libs/libsndfile-1.0.2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	mmx? ( dev-lang/nasm )"

src_prepare() {
	# The frontened tries to link staticly, but we prefer shared libs
	epatch "${FILESDIR}"/${PN}-3.98-shared-frontend.patch

	# If ccc (alpha compiler) is installed on the system, the default
	# configure is broken, fix it to respect CC.  This is only
	# directly broken for ARCH=alpha but would affect anybody with a
	# ccc binary in their PATH.  Bug #41908  (26 Jul 2004 agriffis)
	epatch "${FILESDIR}"/${PN}-3.96-ccc.patch

	# Patch gtk stuff, otherwise eautoreconf dies
	epatch "${FILESDIR}"/${PN}-3.98-gtk-path.patch

	# Read and write from std* when sndfile is used
	epatch "${FILESDIR}"/${PN}-3.98.2-get_audio.patch

	# It fails parallel make otherwise when enabling nasm...
	mkdir libmp3lame/i386/.libs || die

	AT_M4DIR="${S}" eautoreconf
	epunt_cxx # embedded bug #74498
}

src_configure() {
	local myconf
	use sndfile && myconf="--with-fileio=sndfile"
	# The user sets compiler optimizations... But if you'd like
	# lame to choose it's own... uncomment one of these (experiMENTAL)
	# myconf="${myconf} --enable-expopt=full \
	# myconf="${myconf} --enable-expopt=norm \

	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		$(use_enable debug debug norm) \
		$(use_enable mmx nasm) \
		--disable-mp3x \
		$(use_enable mp3rtp) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" pkghtmldir="/usr/share/doc/${PF}/html" install || die
	dobin misc/mlame || die

	dodoc API ChangeLog HACKING README* STYLEGUIDE TODO USAGE || die
	dohtml misc/lameGUI.html Dll/LameDLLInterface.htm || die

	find "${D}" -name '*.la' -exec rm -f '{}' +
}
