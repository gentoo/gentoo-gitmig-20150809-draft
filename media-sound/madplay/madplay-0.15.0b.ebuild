# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/madplay/madplay-0.15.0b.ebuild,v 1.1 2003/07/19 06:01:55 raker Exp $

IUSE="debug nls alsa"

DESCRIPTION="The MAD audio player"
HOMEPAGE="http://mad.sourceforge.net/
	http://www.underbit.com/products/mad/"
SRC_URI="mirror://sourceforge/mad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/glibc
	!media-sound/mad
	nls? ( sys-devel/gettext )
	alsa? ( >=media-libs/alsa-lib-0.9.0 )"

S=${WORKDIR}/${P}

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

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die

	dodoc CHANGES COPYRIGHT CREDITS README TODO VERSION
}
