# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmss/gkrellmss-2.3.ebuild,v 1.16 2007/04/26 17:46:36 lack Exp $

inherit gkrellm-plugin

IUSE="nls"

DESCRIPTION="A plugin for GKrellM2 that has a VU meter and a sound chart"
HOMEPAGE="http://members.dslextreme.com/users/billw/gkrellmss/gkrellmss.html"
SRC_URI="http://web.wt.net/~billw/gkrellmss/${P}.tar.gz"

DEPEND="=sci-libs/fftw-2*
	media-sound/esound"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc ~alpha"

PLUGIN_SO="src/gkrellmss.so"
PLUGIN_DOCS="Themes"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}
	epatch ${FILESDIR}/gkrellmss-patch-2.3.diff
}

src_compile() {
	local myconf

	use nls && myconf="${myconf} enable_nls=1"

	emake ${myconf} || die
}

