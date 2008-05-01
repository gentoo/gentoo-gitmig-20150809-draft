# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/timidity-freepats/timidity-freepats-20060219.ebuild,v 1.2 2008/05/01 15:15:50 maekke Exp $

IUSE=""

MY_PN="${PN/timidity-/}"

DESCRIPTION="Free and open set of instrument patches"
HOMEPAGE="http://freepats.opensrc.org/"
SRC_URI="${HOMEPAGE}/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"

# Only installs datafiles
RESTRICT="binchecks strip"

# These can be used for libmodplug too, so don't depend on timidity++
DEPEND=">=app-admin/eselect-timidity-20061203"
RDEPEND=""

S="${WORKDIR}/${MY_PN}"

src_install() {
	insinto /usr/share/timidity/${MY_PN}

	newins freepats.cfg timidity.cfg
	doins -r Drum_000 Tone_000

	dodoc README
}

pkg_postinst() {
	eselect timidity update --global --if-unset
}
