# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/kdetv/kdetv-0.8.4.ebuild,v 1.2 2004/11/19 21:47:53 carlo Exp $

inherit kde

DESCRIPTION="A TV application for KDE"
HOMEPAGE="http://www.kwintv.org/"
SRC_URI="http://dziegel.free.fr/releases/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="arts lirc"

DEPEND=">=media-libs/zvbi-0.2.4"
RDEPEND=">=media-libs/zvbi-0.2.4"
need-kde 3.2


src_unpack() {
	LANGS="bg br ca cs cy da de en_GB es et fi fr ga gl hu is it nb nl pl pt pt_BR ro ru sr sv ta tr xx"
	LANGS_DOC="it nl pt sv"

	MAKE_PO=$(echo "${LINGUAS} ${LANGS}" | fmt -w 1 | sort | uniq -d | fmt -w 10000)
	MAKE_DOC=$(echo "${LINGUAS} ${LANGS_DOC}" | fmt -w 1 | sort | uniq -d | fmt -w 10000)

	kde_src_unpack
	sed -ier "s:^SUBDIRS =.*:SUBDIRS = ${MAKE_PO}:" ${S}/po/Makefile.in || die "sed for locale failed"
	sed -ier "s:^SUBDIRS =.*:SUBDIRS = \. ${MAKE_DOC} kdetv:" ${S}/doc/Makefile.in || die "sed for locale failed"
}

src_compile() {
	local myconf="$(use_enable arts) $(use_enable lirc kdetv-lirc)"
	kde_src_compile all
}
