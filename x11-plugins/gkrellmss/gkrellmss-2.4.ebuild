# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmss/gkrellmss-2.4.ebuild,v 1.7 2004/09/02 18:22:39 pvdabeel Exp $

inherit eutils

IUSE="nls"

DESCRIPTION="A plugin for GKrellM2 that has a VU meter and a sound chart"
HOMEPAGE="http://gkrellm.net/gkrellmss/gkrellmss.html"
SRC_URI="http://web.wt.net/~billw/gkrellmss/${P}.tar.gz"

DEPEND="=app-admin/gkrellm-2*
	=dev-libs/fftw-2*
	media-sound/esound"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc ~alpha ~amd64"

src_unpack() {
	unpack ${A}

	cd ${S}
#	epatch ${FILESDIR}/gkrellmss-patch-2.3.diff
}

src_compile() {
	local myconf

	use nls && myconf="${myconf} enable_nls=1"

	addpredict /dev/snd
	emake ${myconf} || die
}

src_install () {
	exeinto /usr/lib/gkrellm2/plugins
	doexe src/gkrellmss.so
	dodoc README Changelog Themes
}
