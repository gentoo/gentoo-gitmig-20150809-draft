# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libwmf/libwmf-0.2.8.2.ebuild,v 1.5 2004/02/10 22:04:39 agriffis Exp $

inherit libtool

#The configure script finds the 5.50 ghostscript Fontmap file while run.
#This will probably work, especially since the real one (6.50) in this case
#is empty. However beware in case there is any trouble

DESCRIPTION="library for converting WMF files"
HOMEPAGE="http://wvware.sourceforge.net/"
SRC_URI="mirror://sourceforge/wvware/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha amd64 hppa sparc ia64"
IUSE="jpeg X"

DEPEND="virtual/ghostscript
	dev-libs/expat
	dev-libs/libxml2
	>=media-libs/freetype-2.0.1
	sys-libs/zlib
	media-libs/libpng
	jpeg? ( media-libs/jpeg )
	X? ( virtual/x11 )"
# plotutils are not really supported yet, so looks like that's it

src_compile() {
	# Have to use the reverse-deps patch to prevent libwmf from
	# linking an older installed version of libwmflite
	#still needed !? <vapier@gentoo.org>
	#elibtoolize --reverse-deps

	use jpeg || myconf="${myconf} --with-jpeg=no"
	use X || myconf="${myconf} --with-x=no"
	econf \
		${myconf} \
		--with-gsfontdir=/usr/share/ghostscript/fonts \
		--with-fontdir=/usr/share/libwmf/fonts/ \
		--with-docdir=/usr/share/doc/${PF} \
		|| die "./configure failed"

	emake || die
}

src_install () {
	make install \
		DESTDIR=${D} \
		fontdir=/usr/share/libwmf/fonts \
		wmfonedocdir=/usr/share/doc/${PF}/caolan \
		wmfdocdir=/usr/share/doc/${PF} \
		|| die
	dodoc README AUTHORS COPYING CREDITS ChangeLog NEWS TODO
}
