# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/sound-theme-freedesktop/sound-theme-freedesktop-0.ebuild,v 1.4 2008/12/17 17:50:40 ranger Exp $

DESCRIPTION="Default freedesktop.org sound theme following the XDG theming specification"
HOMEPAGE="http://www.freedesktop.org/wiki/Specifications/sound-theme-spec"
SRC_URI="http://0pointer.de/public/${PN}.tar.gz"

LICENSE="GPL-2 LGPL-2 CCPL-Attribution-3.0 CCPL-Attribution-ShareAlike-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/freedesktop"

src_install() {
	local dest="/usr/share/sounds/freedesktop"
	mkdir -p "${D}${dest}"
	mv index.theme stereo "${D}${dest}" || die "Install failed"
	dodoc README || die
}
