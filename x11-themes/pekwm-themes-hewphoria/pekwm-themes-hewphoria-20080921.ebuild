# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/pekwm-themes-hewphoria/pekwm-themes-hewphoria-20080921.ebuild,v 1.2 2008/10/14 20:10:36 yngwin Exp $

DESCRIPTION="A collection of PekWM themes from hewphoria"
HOMEPAGE="http://hewphoria.com/"
SRC_URI="http://devnull.core.ws/distfiles/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-wm/pekwm"
DEPEND="${RDEPEND}"

src_install() {
	insinto /usr/share/pekwm/themes
	doins -r * || die "install failed"
}

pkg_postinst() {
	echo
	einfo "The themes are installed into /usr/share/pekwm/themes/"
	einfo "Note: If a theme looks broken just re-run pekwm."
	echo
}
