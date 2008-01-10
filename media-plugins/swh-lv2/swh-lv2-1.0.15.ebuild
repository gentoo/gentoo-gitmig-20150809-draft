# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/swh-lv2/swh-lv2-1.0.15.ebuild,v 1.1 2008/01/10 08:24:32 aballier Exp $

inherit toolchain-funcs multilib

DESCRIPTION="Large collection of LV2 audio plugins/effects"
HOMEPAGE="http://plugin.org.uk/"
SRC_URI="http://plugin.org.uk/lv2/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=sci-libs/fftw-3*"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-util/pkgconfig"

src_compile() {
	emake CC=$(tc-getCC) || die "make failed"
}

src_install() {
	emake INSTALL_DIR="${D}/usr/$(get_libdir)/lv2" install-system || die "failed to install"
	dodoc README
}
