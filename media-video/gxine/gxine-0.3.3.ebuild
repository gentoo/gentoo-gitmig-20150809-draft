# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gxine/gxine-0.3.3.ebuild,v 1.8 2003/12/29 16:06:34 bazik Exp $

inherit nsplugins

DESCRIPTION="GTK+ Front-End for libxine"
HOMEPAGE="http://xine.sourceforge.net/"
LICENSE="GPL-2"

DEPEND="media-libs/libpng
	>=media-libs/xine-lib-1_beta10
	>=x11-libs/gtk+-2.0.0
	lirc? ( app-misc/lirc )
	X? ( virtual/x11 )"
RDEPEND="nls? ( sys-devel/gettext )"

IUSE="X nls lirc"

SLOT="0"
KEYWORDS="x86 ~ppc sparc"

S=${WORKDIR}/${P}
SRC_URI="mirror://sourceforge/xine/${P}.tar.gz"

src_compile() {

	# Most of these are not working currently, but are here for completeness
	local myconf
	use X	   || myconf="${myconf} --disable-x11 --disable-xv"
	use nls	   || myconf="${myconf} --disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install() {

	make DESTDIR=${D} \
		docdir=/usr/share/doc/${PF} \
		docsdir=/usr/share/doc/${PF} \
		install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README

	inst_plugin /usr/lib/gxine/gxineplugin.so
}
