# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-1.7.1.ebuild,v 1.2 2004/10/26 16:11:36 carlo Exp $

inherit kde

DESCRIPTION="A Latex Editor and TeX shell for kde"
HOMEPAGE="http://kile.sourceforge.net"
SRC_URI="mirror://sourceforge/kile/${P}.tar.bz2"

IUSE="kde"
SLOT=0

KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
LICENSE="GPL-2"

DEPEND="dev-lang/perl"
RDEPEND="virtual/tetex
	kde? ( kde-base/kdegraphics )"
need-kde 3.2

I18N="${PN}-i18n-${PV%.*}"

# These are the languages and translated documentation supported by the Kile 
# i18n package as of version 1.7. If you are using this ebuild as a model for another
# ebuild for another version of Kile, DO check whether these values are different.
# Check the {po,doc}/Makefile.am files in kile-i18n package.
LANGS="da de en_GB es et fr hu it nl pt pt_BR sr sv ta"
LANGS_DOC="da es et fr it nl pt pt_BR sv"

MAKE_PO=$(echo "${LINGUAS} ${LANGS}" | fmt -w 1 | sort | uniq -d | fmt -w 10000)
MAKE_DOC=$(echo "${LINGUAS} ${LANGS_DOC}" | fmt -w 1 | sort | uniq -d | fmt -w 10000)

if [ -n "$MAKE_PO" ] ; then
	SRC_URI="${SRC_URI} mirror://sourceforge/kile/${I18N}.tar.bz2"
fi

src_compile() {
	local _S=${S}

	# Build process of Kile
	kde_src_compile

	# Build process of Kile-i18n, select LINGUAS elements
	S=${WORKDIR}/${I18N}
	if [ -n "${LINGUAS}" -a -d "${S}" ] ; then
		sed -i -e "s:^SUBDIRS = .*:SUBDIRS = ${MAKE_PO}:" ${S}/po/Makefile.in
		sed -i -e "s:^SUBDIRS = .*:SUBDIRS = ${MAKE_DOC}:" ${S}/doc/Makefile.in
		kde_src_compile
	fi
	S=${_S}
}

src_install() {
	make DESTDIR=${D} install || die

	if [ -n "${LINGUAS}" -a -d "${WORKDIR}/${I18N}" ]; then
		cd ${WORKDIR}/${I18N}
		make DESTDIR=${D} install || die
	fi
}
