# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vorbis-tools/vorbis-tools-1.0.1.ebuild,v 1.2 2003/11/23 15:03:09 mholzer Exp $

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="tools for using the Ogg Vorbis sound file format"
SRC_URI="http://www.vorbis.com/files/${PV}/unix/${P}.tar.gz"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"

RDEPEND=">=media-libs/libvorbis-1.0
	>=media-libs/libao-0.8.2
	>=net-ftp/curl-7.9"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"
LICENSE="as-is"

src_compile() {

	local myconf
	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	rm -rf ${D}/usr/share/doc
	dodoc AUTHORS COPYING README
	docinto ogg123
	dodoc ogg123/ogg123rc-example
}
