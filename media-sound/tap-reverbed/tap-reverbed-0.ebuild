# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/tap-reverbed/tap-reverbed-0.ebuild,v 1.2 2005/07/19 08:13:39 dholm Exp $

IUSE=""

MY_P="${PN}-r0"
DESCRIPTION="TAP Reverb Editor is the standalone JACK counterpart of the LADSPA plugin TAP Reverberator, which is part of the TAP-plugins LADSPA plugin set."
HOMEPAGE="http://tap-plugins.sourceforge.net/reverbed.html"
SRC_URI="mirror://sourceforge/tap-plugins/${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="media-libs/ladspa-sdk
	media-plugins/tap-plugins
	>=x11-libs/gtk+-2
	media-sound/jack-audio-connection-kit"
RDEPEND="$DEPEND
	dev-util/pkgconfig"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einfo ${D}
	einstall

	dodoc COPYING README AUTHORS INSTALL
	insinto /usr/share/tap-reverbed
	insopts -m0666
	doins src/\.reverbed
}

pkg_postinst() {
	einfo "TAP Reverb Editor expects the configuration file '.reverbed'"
	einfo "to be in the user's home directory.  The default '.reverbed'"
	einfo "file can be found in the /usr/share/tap-reverbed directory"
	einfo "and should be manually copied to the user's directory."
}
