# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/kdetv/kdetv-0.8.4.ebuild,v 1.1 2004/11/19 19:59:00 motaboy Exp $

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

src_compile() {
	LANGS="bg ca cs da de en_GB es et fr hu is it nb nl pt pt_BR ro ru sv ta tr xx"
	MAKE_PO=$(echo "${LINGUAS} ${LANGS}" | fmt -w 1 | sort | uniq -d | fmt -w 1000)

	sed -ier "s:^SUBDIRS =.*:SUBDIRS = ${MAKE_PO}:" ${S}/po/Makefile.in
	local myconf="$(use_enable arts) $(use_enable lirc kdetv-lirc)"
	kde_src_compile all
}
