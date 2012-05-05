# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/tangerine-icon-theme/tangerine-icon-theme-0.26.ebuild,v 1.11 2012/05/05 04:10:04 jdhore Exp $

EAPI=2
inherit autotools gnome2-utils

DESCRIPTION="a derivative of the standard Tango theme, using a more orange approach"
HOMEPAGE="http://packages.ubuntu.com/gutsy/x11/tangerine-icon-theme"
SRC_URI="mirror://gentoo/${PN}_${PV}.tar.gz
	http://www.gentoo.org/images/gentoo-logo.svg"

LICENSE="CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="png"

RDEPEND=">=x11-themes/gnome-icon-theme-2.24"
DEPEND=">=gnome-base/librsvg-2.12.3
	|| ( media-gfx/imagemagick[png?] media-gfx/graphicsmagick[imagemagick,png?] )
	>=x11-misc/icon-naming-utils-0.8.2
	virtual/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

RESTRICT="binchecks strip"

src_unpack() { unpack ${PN}_${PV}.tar.gz; }
src_prepare() {
	cp "${DISTDIR}"/gentoo-logo.svg scalable/places/start-here.svg \
		|| die "cp failed"

	for res in 16 22 32; do
		rsvg -w ${res} -h ${res} scalable/places/start-here.svg \
			${res}x${res}/places/start-here.png || die
	done

	intltoolize --force --copy --automake || die
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable png png-creation) \
		$(use_enable png icon-framing)
}

src_install() {
	addwrite /root/.gnome2
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
