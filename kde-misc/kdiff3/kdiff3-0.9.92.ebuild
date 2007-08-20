# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdiff3/kdiff3-0.9.92.ebuild,v 1.9 2007/08/20 18:42:25 keytoaster Exp $

inherit kde

DESCRIPTION="KDE-based frontend to diff3"
HOMEPAGE="http://kdiff3.sourceforge.net/"
SRC_URI="mirror://sourceforge/kdiff3/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="sys-apps/diffutils"

need-kde 3.5

LANGS="ar az bg br ca cs cy da de el en_GB es et fr ga gl hi hu is it ja ka lt
nb nl pl pt pt_BR ro ru rw sk sr sr@Latn sv ta tg tr uk zh_CN"

LANGS_DOC="da de en es et fr it nl pt sv"

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

		if [[ -n ${LANGS_DOC} ]]; then
			MAKE_DOC=$(echo $(echo "${LINGUAS} ${LANGS_DOC}" | tr ' ' '\n' | sort | uniq -d))
			einfo "Enabling documentation for: ${MAKE_DOC}"
			[[ -n ${MAKE_DOC} ]] && [[ -n ${DOC_DIR_SUFFIX} ]] && MAKE_DOC=$(echo "${MAKE_DOC}" | tr '\n' ' ') && MAKE_DOC="${MAKE_DOC// /${DOC_DIR_SUFFIX} }"
			sed -i -e "s:^SUBDIRS =.*:SUBDIRS = ${MAKE_DOC} :" \
				"${KDE_S}/doc/Makefile.am" || die "sed for locale failed"
			rm -f "${KDE_S}/configure"
		fi
	fi

	# Fixes bug 186942
	epatch ${FILESDIR}/${P}-fix-desktop-file.patch
}
