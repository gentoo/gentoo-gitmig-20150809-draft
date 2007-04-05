# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacious/audacious-1.3.2.ebuild,v 1.1 2007/04/05 12:36:57 chainsaw Exp $

inherit flag-o-matic

DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="http://audacious-media-player.org/"
SRC_URI="http://static.audacious-media-player.org/release/${P}.tgz
	 mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="chardet nls"

RDEPEND=">=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2.3.1
	>=dev-libs/libmcs-0.4.1
	dev-libs/libxml2
	media-libs/libsamplerate"

DEPEND="${RDEPEND}
	nls? ( dev-util/intltool )
	>=dev-util/pkgconfig-0.9.0"

PDEPEND=">=media-plugins/audacious-plugins-1.3.1"

src_compile() {
	# Bug #42893
	replace-flags "-Os" "-O2"
	# Bug #86689
	is-flag "-O*" || append-flags -O

	econf \
		--enable-mcs \
		--enable-samplerate \
		$(use_enable chardet) \
		$(use_enable nls) \
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

pkg_postinst() {
	elog "Note that you need to recompile *all* third-party plugins to use Audacious 1.3"
	elog "Failure to do so may cause the player to crash. If you note any instability "
	elog "you should unmerge all plugins (except for audacious-plugins) before you file a bug."
}
