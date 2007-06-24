# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/filelight-i18n/filelight-i18n-1.0.ebuild,v 1.1 2007/06/24 16:38:30 philantrop Exp $

inherit kde

MY_P="${PN/i18n/${PV}}-i18n-20070422"
DESCRIPTION="Translations for kde-misc/filelight"
HOMEPAGE="http://www.methylblue.com/filelight/"
SRC_URI="http://www.methylblue.com/filelight/packages/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

DEPEND="~kde-misc/filelight-1.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

LANGS="az bg br ca cs cy da de el en_GB es et fr ga gl is it ja ka lt nb nl pl
pt pt_BR ro ru rw sr sr@Latn sv ta tr uk"
LANGS_DOC="da es et it pt ru sv"

for lang in ${LANGS}; do
	IUSE="${IUSE} linguas_${lang}"
done

src_unpack(){
	kde_src_unpack
	rm -f "${S}/configure"

	local MAKE_PO=$(echo "${LINGUAS} ${LANGS}" | fmt -w 1 | sort | uniq -d | tr '\n' ' ')
	elog "Enabling translations for: en ${MAKE_PO}"
	sed -i -e "s:^SUBDIRS =.*:SUBDIRS = . ${MAKE_PO}:" "${S}/po/Makefile.am" || die "sed for locale failed"

	if use doc; then
		local MAKE_DOC=$(echo "${LINGUAS} ${LANGS_DOC}" | fmt -w 1 | sort | uniq -d | tr '\n' ' ')
		elog "Enabling documentation for: en ${MAKE_DOC}"
		sed -i -e "s:^SUBDIRS =.*:SUBDIRS = filelight ${MAKE_DOC}:" "${S}/doc/Makefile.am" || die "sed for locale (docs) failed"
	fi
}
