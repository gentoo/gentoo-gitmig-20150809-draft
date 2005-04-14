# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/madplay/madplay-0.15.0b.ebuild,v 1.11 2005/04/14 15:05:52 geoman Exp $

DESCRIPTION="The MAD audio player"
HOMEPAGE="http://mad.sourceforge.net"
SRC_URI="mirror://sourceforge/mad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~ppc ~sparc ~x86 -mips"
IUSE="debug nls alsa"

DEPEND="virtual/libc
	~media-libs/libmad-${PV}
	~media-libs/libid3tag-${PV}
	nls? ( >=sys-devel/gettext-0.11.2 )
	alsa? ( >=media-libs/alsa-lib-0.9.0 )"

src_compile() {
	local myconf

	myconf="--with-gnu-ld"
	# --enable-profiling      generate profiling code
	# --enable-experimental   enable experimental code
	# --with-esd              use Enlightened Sound Daemon (EsounD) 
	#                         as default

	use debug && myconf="${myconf} --enable-debugging" \
		|| myconf="${myconf} --disable-debugging"

	use nls || myconf="${myconf} --disable-nls"

	use alsa && myconf="${myconf} --with-alsa"

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"

	dodoc CHANGES COPYRIGHT CREDITS README TODO VERSION
}
