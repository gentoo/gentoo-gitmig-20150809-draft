# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/madplay/madplay-0.15.1b.ebuild,v 1.1 2004/02/18 09:37:45 mholzer Exp $

IUSE="debug nls"

DESCRIPTION="The MAD audio player"
HOMEPAGE="http://mad.sourceforge.net"
SRC_URI="mirror://sourceforge/mad/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~mips ~ia64 ~amd64"

DEPEND="virtual/glibc
	~media-libs/libmad-${PV}
	~media-libs/libid3tag-${PV}
	nls? ( >=sys-devel/gettext-0.11.2 )"

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

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"

	dodoc CHANGES COPYRIGHT CREDITS README TODO VERSION
}
