# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmess/kmess-1.5.2.ebuild,v 1.1 2009/05/14 13:17:25 scarabeus Exp $

inherit kde eutils

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="KMess is an alternative MSN Messenger chat client for Linux."
HOMEPAGE="http://www.kmess.org"
SRC_URI="mirror://sourceforge/kmess/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

LANGS="ar ca da de es et fi fr hu it ko nb nl pt_BR sl sv th tr zh_CN zh_TW"

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
	elog "- www-plugins/adobe-flash		provides support for winks"
	echo
}
