# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xine-ui/xine-ui-0.99.3_pre20041022.ebuild,v 1.1 2004/10/23 03:50:01 chriswhite Exp $

inherit eutils

DESCRIPTION="Xine movie player"
HOMEPAGE="http://xine.sourceforge.net/"
SRC_URI="mirror://sourceforge/xine/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc64 ~sparc"
IUSE="X gnome nls directfb lirc aalib"

S=${WORKDIR}/${PN}

DEPEND="media-libs/libpng
	>=media-libs/xine-lib-1_rc3
	>=net-misc/curl-7.10.2
	lirc? ( app-misc/lirc )
	X? ( virtual/x11 )
	aalib? ( media-libs/aalib )
	gnome? ( =gnome-base/orbit-0* )
	directfb? ( media-libs/aalib
		>=dev-libs/DirectFB-0.9.9 )"
RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {

	unpack ${A}
	cd ${S}

	use directfb || sed -i "s:dfb::" src/Makefile.in
}

src_compile() {

	local myconf=""

	use X || myconf="${myconf} --disable-x11 --disable-xv"
	use aalib || sed -e 's:no_aalib="":no_aalib="yes":g' \
		-i configure || die "could not disable aalib"


	myconf="${myconf} $(use_enable nls)"
	myconf="${myconf} $(use_enable lirc)"

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
