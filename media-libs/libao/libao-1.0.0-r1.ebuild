# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libao/libao-1.0.0-r1.ebuild,v 1.4 2010/08/24 22:39:23 hwoarang Exp $

EAPI=3
inherit eutils libtool

DESCRIPTION="the audio output library"
HOMEPAGE="http://www.xiph.org/ao/"
SRC_URI="http://downloads.xiph.org/releases/ao/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="alsa nas mmap pulseaudio static-libs"

RDEPEND="alsa? ( media-libs/alsa-lib )
	nas? ( media-libs/nas )
	pulseaudio? ( media-sound/pulseaudio )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-pulseaudio.patch
	sed -i -e 's:-O20::' configure || die
	elibtoolize
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--disable-dependency-tracking \
		--disable-esd \
		$(use_enable alsa alsa) \
		$(use_enable mmap alsa-mmap) \
		--disable-arts \
		$(use_enable nas) \
		$(use_enable pulseaudio pulse)
}

src_install() {
	emake DESTDIR="${D}" docdir="/usr/share/doc/${PF}/html" install || die
	dodoc AUTHORS CHANGES README TODO
	find "${ED}" -name '*.la' -exec rm -f '{}' +
}
