# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kima/kima-0.7.4.ebuild,v 1.1 2007/08/23 17:07:08 philantrop Exp $

inherit kde

DESCRIPTION="Hardware monitoring applet for Kicker"
HOMEPAGE="http://kima.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"

SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=sys-apps/hal-0.5.9-r1"

need-kde 3.5

LANGS="de es hu id ru sv tr"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

src_unpack() {
	kde_src_unpack

	local MAKE_LANGS
	cd "${WORKDIR}/${P}/po"
	for X in ${LANGS} ; do
		use linguas_${X} && MAKE_LANGS="${MAKE_LANGS} ${X}.po"
	done
	rm -f ${S}/configure
	sed -i -e "s:POFILES =.*:POFILES = ${MAKE_LANGS}:" Makefile.am
}
