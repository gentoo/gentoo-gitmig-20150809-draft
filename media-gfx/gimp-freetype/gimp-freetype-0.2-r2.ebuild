# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp-freetype/gimp-freetype-0.2-r2.ebuild,v 1.3 2002/07/23 04:33:46 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GIMP freetype text plugin"
SRC_URI="http://freetype.gimp.org/gimp-freetype-0.2.tar.gz"
HOMEPAGE="http://freetype.gimp.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-gfx/gimp-1.2.3-r1 
	>=media-libs/freetype-2.0.1"
	
RDEPEND="nls? ( sys-devel/gettext )"


src_compile() {
	
	local myconf
	use nls || myconf="${myconf} --disable-nls"

	econf \
	--sysconfdir=/etc/gimp/1.2/	\
	--with-gimp-exec-prefix=/usr \
	${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} prefix=${D}/usr\
	install || die
	dodoc AUTHORS ChangeLog COPYING NEWS README* TODO
}
