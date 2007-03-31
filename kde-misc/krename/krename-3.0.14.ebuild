# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krename/krename-3.0.14.ebuild,v 1.1 2007/03/31 17:56:48 carlo Exp $

inherit kde

# version does not change with every release
DOC="krename-3.0.12.pdf"

DESCRIPTION="KRename - a very powerful batch file renamer."
HOMEPAGE="http://www.krename.net/"
SRC_URI="mirror://sourceforge/krename/${P}.tar.bz2
	doc? ( mirror://sourceforge/krename/${DOC} )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

need-kde 3.5

LANGS="bs de es fr hu it ja nl pl pt_BR ru sl sv tr zh_CN zh_TW"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

PATCHES="${FILESDIR}/krename-3.0.14-desktop-entry-diff"

src_unpack() {
	kde_src_unpack
	cd "${WORKDIR}/${P}/po"
	for X in ${LANGS} ; do
		use linguas_${X} || rm -f "${X}."*
	done
	rm -f "${S}/configure"
}

src_install() {
	kde_src_install

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins ${DISTDIR}/${DOC}
	fi
}
