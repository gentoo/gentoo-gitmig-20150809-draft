# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/worker/worker-2.17.2.ebuild,v 1.3 2009/03/11 19:16:53 mr_bones_ Exp $

EAPI=2
inherit eutils

DESCRIPTION="Worker Filemanager: Amiga Directory Opus 4 clone"
HOMEPAGE="http://www.boomerangsworld.de/worker/"
SRC_URI="http://www.boomerangsworld.de/worker/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="avfs unicode"

RDEPEND="x11-libs/libSM
	avfs? ( sys-fs/avfs )"
DEPEND="${RDEPEND}"

src_compile() {
	econf	$(use_enable unicode utf-8) \
		$(use_with avfs) || die "./configure failed"
	emake || die "make failed"
}

src_prepare() {
	epatch "${FILESDIR}/${P}-gcc43.patch"
}

src_install() {
	einstall || die "make install failed"
	doman man/worker.1
	dodoc AUTHORS ChangeLog INSTALL NEWS README README_LARGEFILES THANKS
	make_desktop_entry ${PN} Worker WorkerIcon "FileManager"
}
