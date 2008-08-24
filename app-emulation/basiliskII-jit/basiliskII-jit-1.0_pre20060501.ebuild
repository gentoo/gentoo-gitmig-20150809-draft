# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/basiliskII-jit/basiliskII-jit-1.0_pre20060501.ebuild,v 1.3 2008/08/24 12:51:33 maekke Exp $

inherit flag-o-matic eutils

S="${WORKDIR}/BasiliskII-1.0/src/Unix"
DESCRIPTION="Basilisk II Macintosh Emulator"
HOMEPAGE="http://gwenole.beauchesne.info/projects/basilisk2/"
SRC_URI="http://gwenole.beauchesne.info/projects/basilisk2/files/BasiliskII_src_01052006.tar.bz2"

LICENSE="|| ( GPL-2 LGPL-2.1 )"
KEYWORDS="~amd64 -ppc ~x86"
SLOT="0"

IUSE="dga esd fbdev gtk jit nls sdl xv"

RDEPEND="esd? ( media-sound/esound )
	!sdl? ( fbdev? ( x11-drivers/xf86-video-fbdev ) )
	gtk? ( >=x11-libs/gtk+-1.3.15 gnome-base/libgnomeui )
	!sdl? ( dga? ( x11-libs/libXxf86dga ) )
	sdl? ( media-libs/libsdl )
	nls? ( virtual/libintl )
	x11-libs/libSM
	x11-libs/libXi
	x11-libs/libXxf86vm"

DEPEND="${RDEPEND}
	!sdl? ( dga? ( x11-proto/xf86dgaproto ) )
	nls? ( sys-devel/gettext )
	x11-proto/xf86vidmodeproto
	x11-proto/xextproto
	x11-proto/xproto
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix up the vendor (bug 35352)
	sed -i \
		-e "s/Mandrake/Gentoo/g" keycodes || \
			die "sed keycodes failed"

	#prevent prestripped binary
	sed -i -e '/^INSTALL_PROGRAM/s/-s//' Makefile.in

	if ( use sdl && ( use fbdev || use dga ) ) ; then
		elog "SDL support was requested, disabling DGA and fbdev"
	elif ( use dga && use fbdev ) ; then
		elog "DGA support was requested, disabling fbdev"
	fi
}

src_compile() {
	#fpu_x86 doesnt compile properly if -O3 or greater :(
	replace-flags -O[3-9] -O2

	local myflags

	use jit && myflags="--enable-jit-compiler"

	econf $(use_with esd) \
		$(use_with gtk) \
		$(use_with dga xf86-dga) \
		$(use_with  fbdev-dga) \
		$(use_enable nls) \
		$(use_enable sdl sdl-video) \
		$(use_enable sdl sdl-audio) \
		$(use_enable xv xf86-vidmode) \
		${myflags}

	emake || die "emake failed"

}

src_install() {

	emake DESTDIR="${D}" install || die "Install failed"

	cd ../../
	dodoc ChangeLog README TECH TODO
}

pkg_postinst() {
	einfo ""
	einfo "Please read the README doc file for information on networking"
	einfo "in Basilisk II."
	einfo ""
	einfo "Basilisk II requires a Mac II or Mac Classic ROM to work."
	einfo ""
	einfo "Mac OS 7.5.3r2 is available freely from the Apple Homepage."
	einfo ""
	einfo "System ROMs can be retreived from a real Mac, see info/man pages."
}
