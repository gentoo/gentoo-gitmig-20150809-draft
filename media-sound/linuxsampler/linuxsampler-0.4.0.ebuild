# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/linuxsampler/linuxsampler-0.4.0.ebuild,v 1.1 2007/08/19 19:00:38 drac Exp $

DESCRIPTION="LinuxSampler is a software audio sampler engine with professional grade features."
HOMEPAGE="http://www.linuxsampler.org/"
SRC_URI="http://download.linuxsampler.org/packages/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc jack"

RDEPEND=">=dev-db/sqlite-3
	>=media-libs/liblscp-0.3
	>=media-libs/libgig-3.1
	media-libs/alsa-lib
	jack? ( media-sound/jack-audio-connection-kit )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_compile() {
	econf
	emake -j1 || die "emake failed."

	if use doc; then
		emake -j1 docs || die "emake docs failed."
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README

	if use doc; then
		mv "${S}"/doc/html "${D}"/usr/share/doc/${PF}/
	fi
}
