# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/beep-media-player/beep-media-player-0.9.7_rc2-r1.ebuild,v 1.3 2004/10/05 19:38:38 eradicator Exp $

IUSE="nls gnome opengl oggvorbis mikmod alsa oss esd mmx"

inherit flag-o-matic eutils

MY_PN="bmp"
MY_P=bmp-${PV/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Beep Media Player"
HOMEPAGE="http://beepmp.sourceforge.net/"
SRC_URI="mirror://sourceforge/beepmp/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~sparc ~amd64 ~ppc"

RDEPEND="app-arch/unzip
	>=x11-libs/gtk+-2.4
	>=x11-libs/pango-1.2
	>=dev-libs/libxml-1.8.15
	>=gnome-base/libglade-2.3.1
	mikmod? ( >=media-libs/libmikmod-3.1.10 )
	esd? ( >=media-sound/esound-0.2.30 )
	opengl? ( virtual/opengl )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )
	alsa? ( >=media-libs/alsa-lib-1.0 )
	gnome? ( >=gnome-base/gnome-vfs-2.6.0
	         >=gnome-base/gconf-2.6.0 )"

DEPEND="${RDEPEND}
	nls? ( dev-util/intltool )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-mime.patch
}

src_compile() {
	local myconf=""

	# Bug #42893
	replace-flags "-Os" "-O2"

	if use gnome; then
		myconf="${myconf} --enable-gconf --enable-gnome-vfs"
	fi

	if use mmx; then
		myconf="${myconf} --enable-simd"
	fi

	econf \
		--with-dev-dsp=/dev/sound/dsp \
		--with-dev-mixer=/dev/sound/mixer \
		`use_enable oggvorbis vorbis` \
		`use_enable oggvorbis oggtest` \
		`use_enable oggvorbis vorbistest` \
		`use_enable esd` \
		`use_enable esd esdtest` \
		`use_enable mikmod` \
		`use_enable mikmod mikmodtest` \
		`use_with mikmod libmikmod` \
		`use_enable opengl` \
		`use_enable nls` \
		`use_enable oss` \
		`use_enable alsa` \
		${myconf} \
		|| die

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die

	insinto /usr/share/pixmaps
	doins beep.svg
	doins beep/beep_mini.xpm

	# Get the app registered for KDE
	insinto /usr/share/applnk/Multimedia
	doins ${D}/usr/share/applications/bmp.desktop

	# We'll use xmms skins / plugins for the time being

	dodir /usr/share/beep
	dosym /usr/share/xmms/Skins /usr/share/beep/Skins
	dosym /usr/share/xmms/Plugins /usr/share/beep/Plugins

	# Plugins want beep-config, this wasn't included
	dobin ${FILESDIR}/beep-config

	dodoc AUTHORS ChangeLog COPYING FAQ NEWS README TODO
}

pkg_postinst() {
	echo
	einfo "This program is unstable on sparc when poking heavily with the GUI."
	einfo "It's reportedly unstable on some x86 boxes also, YMMV."
	echo
	einfo "We're using xmms skins/plugins for the time being, they have been symlinked."
	echo
}
