# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/knetstats/knetstats-1.6.1.ebuild,v 1.6 2007/09/27 13:16:25 angelos Exp $

inherit kde

DESCRIPTION="A simple KDE network monitor that shows statistical information about any network interface in the system tray."
HOMEPAGE="http://knetstats.sourceforge.net"
SRC_URI="mirror://sourceforge/knetstats/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc64 x86"
IUSE=""

need-kde 3

LANGS="bg br cs da de el es et fr ga gl it ja ka nl pl pt pt_BR ru sk sv tr"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

src_unpack() {
	kde_src_unpack

	local MAKE_LANGS
	cd "${WORKDIR}/${P}/translations"
	for X in ${LANGS} ; do
		use linguas_${X} && MAKE_LANGS="${MAKE_LANGS} ${X}"
	done
	rm -f ${S}/configure
	sed -i -e "s:SUBDIRS=.*:SUBDIRS=${MAKE_LANGS}:" Makefile.am
}
