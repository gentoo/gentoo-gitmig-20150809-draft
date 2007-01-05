# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacious/audacious-1.3.0_alpha1.ebuild,v 1.1 2007/01/05 10:30:18 chainsaw Exp $

inherit flag-o-matic

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="http://audacious-media-player.org/"
SRC_URI="http://audacious-media-player.org/release/${MY_P}.tgz
	 mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="chardet nls gnome"

RDEPEND=">=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2.3.1
	dev-libs/libxml2
	gnome? ( >=gnome-base/gconf-2.6.0 )"

DEPEND="${RDEPEND}
	nls? ( dev-util/intltool )
	>=dev-util/pkgconfig-0.9.0"

PDEPEND=">=media-plugins/audacious-plugins-1.3.0_alpha1"

src_compile() {
	# Bug #42893
	replace-flags "-Os" "-O2"
	# Bug #86689
	is-flag "-O*" || append-flags -O

	econf \
		$(use_enable chardet) \
		$(use_enable nls) \
		$(use_enable gnome gconf) \
		|| die

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README

	# Gentoo_ice skin installation; bug #109772
	insinto /usr/share/audacious/Skins/gentoo_ice
	doins "${WORKDIR}"/gentoo_ice/*
	docinto gentoo_ice
	dodoc "${WORKDIR}"/README
}
