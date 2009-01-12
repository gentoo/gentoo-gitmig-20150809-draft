# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/stickers/stickers-0.1.3-r2.ebuild,v 1.4 2009/01/12 16:27:48 mr_bones_ Exp $

EAPI=2
inherit eutils

DESCRIPTION="Stickers Book for small children"
HOMEPAGE="http://users.powernet.co.uk/kienzle/stickers/"
SRC_URI="http://users.powernet.co.uk/kienzle/stickers/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls"

RDEPEND="media-libs/imlib[gtk]
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/gtk+:1
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xproto
	nls? ( sys-devel/gettext )"

src_prepare() {
	# gcc34 fix? (bug #72734)
	sed -i \
		-e '/ONTRACE/d' rc.c \
		|| die "sed failed"
}

src_configure() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"

	./configure \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "configure failed"
}

src_install () {
	emake \
		prefix="${D}/usr" \
		infodir="${D}/usr/share/info" \
		mandir="${D}/usr/share/man" install \
		|| die "emake install failed"
	newicon scenes/Aquarium.scene.xpm ${PN}.xpm
	make_desktop_entry ${PN} Stickers
}
