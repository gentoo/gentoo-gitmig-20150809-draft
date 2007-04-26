# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmss/gkrellmss-2.6.ebuild,v 1.5 2007/04/26 17:46:36 lack Exp $

inherit gkrellm-plugin

IUSE="alsa esd nls"

DESCRIPTION="A plugin for GKrellM2 that has a VU meter and a sound chart"
HOMEPAGE="http://members.dslextreme.com/users/billw/gkrellmss/gkrellmss.html"
SRC_URI="http://web.wt.net/~billw/gkrellmss/${P}.tar.gz"

RDEPEND="=sci-libs/fftw-2*
	esd? ( media-sound/esound )
	alsa? ( media-libs/alsa-lib )"

DEPEND="${RDEPEND}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"

PLUGIN_SO="src/gkrellmss.so"
PLUGIN_DOCS="Themes"

src_compile() {
	local myconf

	use nls && myconf="${myconf} enable_nls=1"

	addpredict /dev/snd
	emake ${myconf} || die
}

