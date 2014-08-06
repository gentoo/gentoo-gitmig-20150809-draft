# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cv/cv-0.4.1.ebuild,v 1.2 2014/08/06 20:09:13 jer Exp $

EAPI=5

DESCRIPTION="Coreutils Viewer: show progress for cp, rm, dd, and so forth"
HOMEPAGE="https://github.com/Xfennec/cv"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i 's/CFLAGS=-g/CFLAGS+=/' Makefile || die
}

src_install() {
	emake PREFIX="${D}/${EPREFIX}/usr" install
}
