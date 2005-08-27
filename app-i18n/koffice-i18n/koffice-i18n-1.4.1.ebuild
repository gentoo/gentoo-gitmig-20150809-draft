# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/koffice-i18n/koffice-i18n-1.4.1.ebuild,v 1.2 2005/08/27 09:37:39 greg_g Exp $

inherit kde

DESCRIPTION="KOffice internationalization package."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND="|| ( ~app-office/koffice-libs-${PV} ~app-office/koffice-${PV} )
	kde-base/kde-i18n"

need-kde 3.3

LANGS="bg ca cs cy da de el en_GB es et fi fr hu it nb nl \
	nn pl pt pt_BR ru sl sr sr@Latn sv ta tg zh_CN"

for X in ${LANGS}; do
	SRC_URI="${SRC_URI} linguas_${X}? ( mirror://kde/stable/koffice-${PV}/src/koffice-l10n/koffice-l10n-${X}-${PV}.tar.bz2 )"
done

pkg_setup() {
	if [ -z "${A}" ]; then
		echo
		eerror "You must define a LINGUAS environment variable that contains a list"
		eerror "of the language codes for which languages you would like to install."
		eerror "Look at the LANGS variable inside the ebuild to see the list of"
		eerror "available languages."
		eerror "e.g.: LINGUAS=\"sv de pt\""
		echo
		die
	fi
}

src_unpack() {
	unpack ${A}
}

src_compile() {
	local _S=${S}
	for dir in `ls ${WORKDIR}`; do
		S=${WORKDIR}/${dir}
		kde_src_compile
	done
	S=${_S}
}

src_install() {
	local _S=${S}
	for dir in `ls ${WORKDIR}`; do
		cd ${WORKDIR}/${dir}
		make DESTDIR=${D} install
	done
	S=${_S}
}
