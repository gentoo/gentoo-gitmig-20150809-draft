# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musicman/musicman-0.11-r1.ebuild,v 1.2 2004/07/17 09:48:21 dholm Exp $

inherit eutils kde

DESCRIPTION="A Konqueror plugin for manipulating ID3 tags in MP3 files"
HOMEPAGE="http://musicman.sourceforge.net/"
SRC_URI="mirror://sourceforge/musicman/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND=">=kde-base/kdebase-3.2.1 \
	>=media-libs/jpeg-6b-r3 \
	>=app-admin/fam-2.7.0 \
	>=media-libs/libart_lgpl-2.3.16"

# The tar.gz doesn't create a musicman-0.11 directory
S="${WORKDIR}/musicman"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-gcc34.patch
	epatch ${FILESDIR}/${P}-amd64.patch
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
}
