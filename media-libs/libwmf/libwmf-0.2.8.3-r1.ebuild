# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libwmf/libwmf-0.2.8.3-r1.ebuild,v 1.2 2005/08/05 01:32:15 vapier Exp $

inherit libtool

#The configure script finds the 5.50 ghostscript Fontmap file while run.
#This will probably work, especially since the real one (6.50) in this case
#is empty. However beware in case there is any trouble

DESCRIPTION="library for converting WMF files"
HOMEPAGE="http://wvware.sourceforge.net/"
SRC_URI="mirror://sourceforge/wvware/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="jpeg X pic xml xml2 debug doc gtk"

RDEPEND="virtual/ghostscript
	xml2? ( !xml? ( dev-libs/libxml2 ) )
	xml? ( dev-libs/expat )
	>=media-libs/freetype-2.0.1
	sys-libs/zlib
	media-libs/libpng
	jpeg? ( media-libs/jpeg )
	X? ( virtual/x11 )
	gtk? ( >=x11-libs/gtk+-2.1.2 ) "
DEPEND="$RDEPEND
	dev-util/pkgconfig"
# plotutils are not really supported yet, so looks like that's it

src_unpack() {
	unpack ${A}
	cd ${S}
	if ! use doc; then
		sed -e 's:doc::' -i Makefile.am
		automake || die "automake filed"
	fi

	if ! use gtk; then
		sed -e 's:@LIBWMF_GDK_PIXBUF_TRUE@:#:' -i src/Makefile.in
	fi
}

src_compile() {
	# Have to use the reverse-deps patch to prevent libwmf from
	# linking an older installed version of libwmflite
	#still needed !? <vapier@gentoo.org>
	#elibtoolize --reverse-deps

	if use xml && use xml2; then
		einfo "You can specify only one flag of xml and xml2."
		einfo "It will be defaulted to expat (like autocheck does)."
		myconf="${myconf} --with-expat --without-libxml2"
	else
		myconf="${myconf} $(use_with xml expat) $(use_with xml2 libxml2)"
	fi

	econf \
		$(use_enable debug) \
		$(use_with jpeg) \
		$(use_with X x) \
		$(use_with pic) \
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
