# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xine-ui/xine-ui-0.9.23-r2.ebuild,v 1.9 2005/03/29 05:18:32 chriswhite Exp $

inherit eutils

DESCRIPTION="Xine movie player"
HOMEPAGE="http://xine.sourceforge.net/"
SRC_URI="mirror://sourceforge/xine/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64 ~alpha"
IUSE="X gnome nls directfb lirc aalib"

DEPEND="media-libs/libpng
	>=media-libs/xine-lib-1_rc3
	>=net-misc/curl-7.10.2
	lirc? ( app-misc/lirc )
	X? ( virtual/x11 )
	aalib? ( media-libs/aalib )
	gnome? ( =gnome-base/orbit-0* )
	directfb? ( >=dev-libs/DirectFB-0.9.9 )"
RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/implicit-config.patch
	epatch ${FILESDIR}/symlink-bug.patch
	epatch ${FILESDIR}/preserve-CFLAGS-${PV}.diff
	epatch ${FILESDIR}/true-false.patch
	use directfb || sed -i "s:dfb::" src/Makefile.in
	sed -i "s:LDFLAGS =:LDFLAGS = -L/lib:" src/xitk/Makefile.in
}

src_compile() {
	rm misc/xine-bugreport
	local myconf=""
	use X || myconf="${myconf} --disable-x11 --disable-xv"
	use nls || myconf="${myconf} --disable-nls"
	use lirc || myconf="${myconf} --disable-lirc"
	use aalib || sed -e 's:no_aalib="":no_aalib="yes":g' \
			-i configure || die "could not disable aalib"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} \
		docdir=/usr/share/doc/${PF} \
		docsdir=/usr/share/doc/${PF} \
		install || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
