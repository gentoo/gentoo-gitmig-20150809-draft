# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kooldock/kooldock-0.4.7.ebuild,v 1.1 2007/10/30 21:47:24 philantrop Exp $

inherit kde

DESCRIPTION=" KoolDock is a dock for KDE with cool visual enhancements and effects"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=50910"
SRC_URI="mirror://sourceforge/kooldock/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
SLOT="0"

need-kde 3.5

S="${WORKDIR}/${PN}"

LANGS="cs de es fr it nl pl sv"

for lang in ${LANGS}; do
	IUSE="${IUSE} linguas_${lang}"
done

src_unpack() {
	kde_src_unpack

	# Adapted from kde.eclass
	if [[ -z ${LINGUAS} ]]; then
		einfo "You can drop some of the translations of the interface and"
		einfo "documentation by setting the \${LINGUAS} variable to the"
		einfo "languages you want installed."
		einfo
		einfo "Enabling all languages"
	else
		if [[ -n ${LANGS} ]]; then
			MAKE_PO=$(echo $(echo "${LINGUAS} ${LANGS}" | tr ' ' '\n' | sort | uniq -d))
			einfo "Enabling translations for: ${MAKE_PO}"
			local tmp=""
			for x in ${MAKE_PO}; do
				tmp+="${x}.po "
			done
			MAKE_PO=${tmp}
			sed -i -e "s:^POFILES =.*:POFILES = ${MAKE_PO}:" "${KDE_S}/po/Makefile.am" \
				|| die "sed for locale failed"

			rm -f "${KDE_S}/configure"
		fi
	fi
}
