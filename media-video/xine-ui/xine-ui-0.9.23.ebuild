# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xine-ui/xine-ui-0.9.23.ebuild,v 1.2 2003/12/30 04:18:01 weeve Exp $

DESCRIPTION="Skinned front end for Xine movie player."
HOMEPAGE="http://xine.sourceforge.net/"
LICENSE="GPL-2"

DEPEND="media-libs/libpng
	>=media-libs/xine-lib-1_rc0
	>=net-ftp/curl-7.10.2
	lirc? ( app-misc/lirc )
	X? ( virtual/x11 )
	media-libs/aalib
	gnome? ( gnome-base/ORBit )
	directfb? ( media-libs/aalib
		>=dev-libs/DirectFB-0.9.9 )"
RDEPEND="nls? ( sys-devel/gettext )"

IUSE="X gnome nls directfb lirc"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"

S=${WORKDIR}/${P}
SRC_URI="mirror://sourceforge/xine/${P}.tar.gz"
RESTRICT="nomirror"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/preserve-CFLAGS-${PV}.diff || die "patch failed"

	use directfb || ( \
		sed -i "s:dfb::" src/Makefile.in
	)

	sed -i "s:LDFLAGS =:LDFLAGS = -L/lib:" src/xitk/Makefile.in
}

src_compile() {

	local myconf
	use X || myconf="${myconf} --disable-x11 --disable-xv"
	use nls || myconf="${myconf} --disable-nls"
	use lirc || myconf="${myconf} --disable-lirc"

	econf ${myconf} || die
	emake || die
}

src_install() {

	make DESTDIR=${D} \
		docdir=/usr/share/doc/${PF} \
		docsdir=/usr/share/doc/${PF} \
		install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
