# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp-freetype/gimp-freetype-0.2-r3.ebuild,v 1.7 2004/04/26 02:14:18 agriffis Exp $

IUSE="nls"

DESCRIPTION="GIMP freetype text plugin"
SRC_URI="http://freetype.gimp.org/${P}.tar.gz"
HOMEPAGE="http://freetype.gimp.org/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND="=media-gfx/gimp-1.2*
	>=media-libs/freetype-2.0.1"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf=""

	use nls || myconf="--disable-nls"

	econf \
		--sysconfdir=/etc/gimp/1.2/ \
		--with-gimp-exec-prefix=/usr \
		${myconf} || die "econf failed"

	emake || die
}

src_install() {
	local GIMP_PLUGIN_DIR=`gimptool --gimpplugindir`

	einstall bindir=${D}/${GIMP_PLUGIN_DIR}/plug-ins || die

	dodoc AUTHORS ChangeLog COPYING NEWS README* TODO
}
