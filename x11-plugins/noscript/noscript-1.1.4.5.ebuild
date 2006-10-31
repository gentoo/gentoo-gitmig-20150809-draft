# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/noscript/noscript-1.1.4.5.ebuild,v 1.6 2006/10/31 07:58:17 kloeri Exp $

inherit mozextension multilib

DESCRIPTION="Firefox plugin to disable javascript"
HOMEPAGE="https://addons.mozilla.org/firefox/722/
		http://noscript.net"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND=">=www-client/mozilla-firefox-1.5.0.7"
DEPEND="${RDEPEND}"

SRC_URI="http://releases.mozilla.org/pub/mozilla.org/extensions/noscript/"${P}"-fx+fl+mz+zm.xpi"

S="${WORKDIR}"

src_unpack() {
	xpi_unpack "${P}"-fx+fl+mz+zm.xpi
}

src_install() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/mozilla-firefox"

	xpi_install "${S}"/"${P}-fx+fl+mz+zm"
}
