# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/konversation/konversation-0.19.ebuild,v 1.2 2006/01/30 16:53:39 flameeyes Exp $

inherit kde

DESCRIPTION="A user friendly IRC Client for KDE3.x"
HOMEPAGE="http://konversation.kde.org/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

need-kde 3

src_unpack() {
	LANGS="bg cs da de el en_GB es et fi fr hi it ja nl pt pt_BR ru sr sr@Latn sv ta tr"
	LANGS_DOC="da es et it nl pt sv"

	MAKE_PO=$(echo $(echo "${LINGUAS} ${LANGS}" | fmt -w 1 | sort | uniq -d))
	MAKE_DOC=$(echo $(echo "${LINGUAS} ${LANGS_DOC}" | fmt -w 1 | sort | uniq -d))

	kde_src_unpack
	sed -i -e "s:^SUBDIRS =.*:SUBDIRS = ${MAKE_PO}:" ${S}/po/Makefile.am || die "sed for locale failed"
	sed -i -e "s:^SUBDIRS =.*:SUBDIRS = ${MAKE_DOC} ${PN}:" ${S}/doc/Makefile.am || die "sed for locale failed"

	rm -f ${S}/configure
	epatch "${FILESDIR}/${P}-gcc41.patch"
}
