# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gsnes9x/gsnes9x-3.12.ebuild,v 1.1 2005/07/22 00:13:20 vapier Exp $

inherit eutils

DESCRIPTION="GNOME front-end for the Snes9X SNES emulator"
HOMEPAGE="http://sourceforge.net/projects/gsnes9x/"
SRC_URI="mirror://sourceforge/gsnes9x/GSnes9x-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls esd debug"

DEPEND="=gnome-base/gnome-libs-1*
	=gnome-base/orbit-0*
	esd? ( media-sound/esound )"

S=${WORKDIR}/GSnes9x-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	autoheader && \
	aclocal -I macros && \
	automake --gnu --include-deps Makefile -c -a && \
	autoconf || die
}

src_compile() {
	econf \
		$(use_with esd) \
		$(use_with debug) \
		$(use_enable nls) \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	rm -r "${D}"/usr/share/gnome/apps
	make_desktop_entry GSnes9x GSnes9x gsnes9x-icon.png
	dodoc AUTHORS ChangeLog NEWS README
}
