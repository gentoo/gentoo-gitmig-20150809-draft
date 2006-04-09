# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/xarchon/xarchon-0.60-r1.ebuild,v 1.2 2006/04/09 10:44:43 tupone Exp $

inherit eutils games

DESCRIPTION="modelled after the golden oldie Archon game"
HOMEPAGE="http://xarchon.seul.org/"
SRC_URI="ftp://ftp.seul.org/pub/xarchon/${P}.tar.gz
	http://xarchon.seul.org/${P}.tar.gz
	mirror://gentoo/${P}-gtk.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="esd joystick" # also has qt support but it fails :/

DEPEND="=x11-libs/gtk+-1*
	<dev-util/glade-2
	esd? ( media-sound/esound )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Applying gtk patch
	# Fixing gcc-3.4 compiling
	# Fixing gcc-4.1 compiling
	# Fixing font missing in gentoo
	epatch "${WORKDIR}/${P}-gtk.patch" \
		"${FILESDIR}"/01_all_gcc34_font.patch \
		"${FILESDIR}"/${P}-gcc41.patch
	sed -i \
		-e 's:gtk12-config:gtk-config:' configure \
		|| die "sed configure failed"
}

src_compile() {
	local mysndconf
	use esd \
		&& mysndconf="--with-esd-prefix=/usr" \
		|| mysndconf="--disable-sound"
	egamesconf \
		--enable-network \
		$(use_enable joystick) \
		--with-default-gtk \
		${mysndconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	egamesinstall || die
	dodoc AUTHORS ChangeLog NEWS README
	prepgamesdirs
}
