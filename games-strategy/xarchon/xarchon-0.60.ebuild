# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/xarchon/xarchon-0.60.ebuild,v 1.2 2004/02/20 07:38:17 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="modelled after the golden oldie Archon game"
HOMEPAGE="http://xarchon.seul.org/"
SRC_URI="ftp://ftp.seul.org/pub/xarchon/${P}.tar.gz
	http://xarchon.seul.org/${P}.tar.gz
	mirror://gentoo/${P}-gtk.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="esd joystick" # also has qt support but it fails :/

DEPEND="virtual/x11
	=x11-libs/gtk+-1*
	<dev-util/glade-2
	esd? ( media-sound/esound )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-gtk.patch
	sed -i 's:gtk12-config:gtk-config:' configure
}

src_compile() {
	local mysndconf
	[ `use esd` ] \
		&& mysndconf="--with-esd-prefix=/usr" \
		|| mysndconf="--disable-sound"
	egamesconf \
		--enable-network \
		`use_enable joystick` \
		--with-default-gtk \
		${mysndconf} \
		|| die
	emake || die
}

src_install() {
	egamesinstall || die
	dodoc AUTHORS ChangeLog NEWS README
	prepgamesdirs
}
