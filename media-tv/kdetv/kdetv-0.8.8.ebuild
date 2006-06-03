# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/kdetv/kdetv-0.8.8.ebuild,v 1.2 2006/06/03 14:19:49 deathwing00 Exp $

inherit kde

DESCRIPTION="A TV application for KDE"
HOMEPAGE="http://www.kdetv.org/"
SRC_URI="http://dziegel.free.fr/releases/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="arts lirc"

DEPEND=">=media-libs/zvbi-0.2.4
	lirc? ( app-misc/lirc )"
need-kde 3.2


src_unpack() {
	LANGS="bg ca br da de cs cy el es et fi ga fr gl hu is it lt nb mt nl pa pl pt ro ru rw ta sr sv tr en_GB pt_BR zh_CN sr@Latn"
	LANGS_DOC="da et fr it nl pt ru sv"

	MAKE_PO=$(echo $(echo "${LINGUAS} ${LANGS}" | fmt -w 1 | sort | uniq -d))
	MAKE_DOC=$(echo $(echo "${LINGUAS} ${LANGS_DOC}" | fmt -w 1 | sort | uniq -d))

	kde_src_unpack
	sed -i -r -e "s:^SUBDIRS =.*:SUBDIRS = ${MAKE_PO}:" ${S}/po/Makefile.in || die "sed for locale failed"
	sed -i -r -e "s:^SUBDIRS =.*:SUBDIRS = \. ${MAKE_DOC} kdetv:" ${S}/doc/Makefile.in || die "sed for locale failed"
}

src_compile() {
	local myconf="$(use_enable arts) $(use_enable lirc kdetv-lirc)"
	kde_src_compile all
}
