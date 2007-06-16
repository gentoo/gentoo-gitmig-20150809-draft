# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/swh-plugins/swh-plugins-0.4.15.ebuild,v 1.1 2007/06/16 14:28:18 drac Exp $

inherit flag-o-matic eutils

DESCRIPTION="Large collection of LADSPA audio plugins/effects"
HOMEPAGE="http://plugin.org.uk"
SRC_URI="http://plugin.org.uk/releases/${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"
IUSE="3dnow nls sse"

DEPEND="media-libs/ladspa-sdk
	dev-util/pkgconfig
	>=sci-libs/fftw-3
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	use amd64 && append-flags -fPIC
	use ppc && append-flags -fPIC
	use ppc-macos && append-flags -fPIC
	use ppc-macos && append-ldflags -lintl -lsystem -lm

	cd "${S}"
	sed -i -e '/MACHINE=/s/.*/MACHINE=""/' configure
	sed -i -r  "s/(^plugindir.*)(lib)/\1$(get_libdir)/g" Makefile.in
}

src_compile() {
	use ppc-macos && myconf="${myconf} --enable-darwin"
	econf ${myconf} \
		$(use_enable sse) \
		$(use_enable 3dnow) \
		$(use_enable nls) \
		--enable-fast-install \
		--disable-dependency-tracking
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README TODO
}

pkg_postinst() {
	ewarn "WARNING: You have to be careful when using the"
	ewarn "swh plugins. Be sure to lower your sound volume"
	ewarn "and then play around a bit with the plugins so"
	ewarn "you get a feeling for it. Otherwise your speakers"
	ewarn "won't like that."
}
