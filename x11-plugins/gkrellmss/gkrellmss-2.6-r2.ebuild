# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmss/gkrellmss-2.6-r2.ebuild,v 1.1 2010/08/11 12:45:34 lack Exp $

EAPI=3
inherit gkrellm-plugin

IUSE="+alsa esd nls"

DESCRIPTION="A plugin for GKrellM2 that has a VU meter and a sound chart"
HOMEPAGE="http://members.dslextreme.com/users/billw/gkrellmss/gkrellmss.html"
SRC_URI="http://web.wt.net/~billw/gkrellmss/${P}.tar.gz"

RDEPEND="=sci-libs/fftw-3*
	esd? ( media-sound/esound )
	alsa? ( media-libs/alsa-lib )"

DEPEND="${RDEPEND}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

PLUGIN_SO="src/gkrellmss.so"
PLUGIN_DOCS="Themes"

pkg_setup() {
	if ! use esd && ! use alsa; then
		die "You must enable at least one of USE=esd or USE=alsa"
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${P}-Respect-LDFLAGS.patch"
}

src_compile() {
	local myconf

	use nls && myconf="${myconf} enable_nls=1"

	addpredict /dev/snd
	emake ${myconf} || die
}
