# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ladspa-cmt/ladspa-cmt-1.14.ebuild,v 1.11 2004/07/14 19:51:14 agriffis Exp $

DESCRIPTION="CMT (computer music toolkit) Lasdpa library plugins"
HOMEPAGE="http://www.ladspa.org/"
LICENSE="LGPL-2.1"
SRC_URI="http://www.ladspa.org/download/cmt_src.tgz"

KEYWORDS="x86"
IUSE=""

SLOT="0"

S=${WORKDIR}/cmt/src

RDEPEND="media-libs/ladspa-sdk"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "/^CFLAGS/ s/-O3/${CFLAGS}/" \
	       -e 's|/usr/local/include||g' \
	       -e 's|/usr/local/lib||g' \
	       makefile
}

src_compile() {
	emake || die
}

src_install() {
	dodoc ../doc/*
	insinto /usr/lib/ladspa
	INSOPTIONS="-m755"
	doins ../plugins/*.so
}
