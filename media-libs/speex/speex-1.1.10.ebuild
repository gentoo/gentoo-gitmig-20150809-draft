# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/speex/speex-1.1.10.ebuild,v 1.3 2006/01/13 12:43:04 vapier Exp $

inherit eutils

DESCRIPTION="Speech encoding library"
HOMEPAGE="http://www.speex.org/"
SRC_URI="http://downloads.xiph.org/releases/speex/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~sh ~sparc ~x86"
IUSE="ogg sse"

DEPEND="virtual/libc
	ogg? ( >=media-libs/libogg-1.0 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-sse.patch
}

src_compile() {
	local myconf

	# cannot --without-ogg
	# use ogg \
	#	&& myconf="--with-ogg=/usr" \
	#	|| myconf="--without-ogg"

	myconf="${myconf} $(use_enable sse)"

	econf ${myconf} || die
	emake || die
}

src_install () {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog README TODO NEWS
}
