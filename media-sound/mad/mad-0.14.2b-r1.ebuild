# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/mad/mad-0.14.2b-r1.ebuild,v 1.5 2002/09/14 03:12:44 woodchip Exp $

S=${WORKDIR}/${P}
HOMEPAGE="http://mad.sourceforge.net/"
DESCRIPTION="A high-quality MP3 decoder"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
DEPEND="virtual/glibc esd? ( media-sound/esound ) nls? ( sys-devel/gettext )"
RDEPEND="${DEPEND}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_compile() {
	local myconf
	use esd || myconf="${myconf} --without-esd"
	use nls || myconf="${myconf} --disable-nls"
	econf \
		--enable-static \
		--enable-shared \
		${myconf} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc CHANGES COPY* CREDITS README TODO VERSION
}
