# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mad/mad-0.14.2b-r2.ebuild,v 1.8 2003/05/20 20:44:54 weeve Exp $

IUSE="nls esd"

S=${WORKDIR}/${P}
HOMEPAGE="http://mad.sourceforge.net/"
DESCRIPTION="A high-quality MP3 decoder"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha sparc"

DEPEND="esd? ( media-sound/esound )
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	use esd || myconf="${myconf} --without-esd"
	use nls || myconf="${myconf} --disable-nls"
	econf \
		--enable-static \
		--enable-shared \
		${myconf}
	emake || make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc CHANGES COPY* CREDITS README TODO VERSION
	#add id3tag.pc
	insinto /usr/lib/pkgconfig/
	doins ${FILESDIR}/id3tag.pc
	# and mad.pc
	doins ${FILESDIR}/mad.pc
}
