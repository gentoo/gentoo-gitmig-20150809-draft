# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmss/gkrellmss-2.3.ebuild,v 1.5 2003/09/06 05:56:25 msterret Exp $

inherit eutils

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="A plugin for GKrellM2 that has a VU meter and a sound chart"
HOMEPAGE="http://gkrellm.net/gkrellmss/gkrellmss.html"
SRC_URI="http://web.wt.net/~billw/${PN}/${P}.tar.gz"

DEPEND="=app-admin/gkrellm-2*
	dev-libs/fftw
	media-sound/esound"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

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

src_install () {
	exeinto /usr/lib/gkrellm2/plugins
	doexe src/gkrellmss.so
	dodoc README Changelog Themes
}
