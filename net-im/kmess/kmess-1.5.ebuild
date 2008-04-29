# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmess/kmess-1.5.ebuild,v 1.2 2008/04/29 12:13:36 armin76 Exp $

inherit kde eutils

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="KMess is an alternative MSN Messenger chat client for Linux."
HOMEPAGE="http://www.kmess.org"
SRC_URI="mirror://sourceforge/kmess/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

LANGS="de"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

need-kde 3.5

src_unpack() {
	kde_src_unpack
	cd "${WORKDIR}/${MY_P}/po"
	for X in ${LANGS} ; do
		use linguas_${X} || rm -f "${X}.po"
	done
	rm -f "${S}/configure"
}

pkg_postinst() {
	kde_pkg_postinst

	echo
	elog "KMess can use the following optional packages:"
	elog "- net-www/netscape-flash		provides support for winks"
	echo
}
