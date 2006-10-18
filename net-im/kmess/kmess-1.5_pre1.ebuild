# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmess/kmess-1.5_pre1.ebuild,v 1.2 2006/10/18 12:59:45 deathwing00 Exp $

inherit kde eutils

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="MSN Messenger clone for KDE"
HOMEPAGE="http://kmess.sourceforge.net"
SRC_URI="mirror://sourceforge/kmess/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

LANGS="ar ca da de et es fi fr it ko nb nl pt_BR sl sv th tr zh_CN zh_TW"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

src_unpack() {
	kde_src_unpack
	mv "${WORKDIR}/${MY_P}/po/ee.po" "${WORKDIR}/${MY_P}/po/et.po"
	cd "${WORKDIR}/${MY_P}/po"
	for X in ${LANGS} ; do
		use linguas_${X} || rm -f "${X}."*
	done
	rm -f "${S}/configure"
}

need-kde 3.4


