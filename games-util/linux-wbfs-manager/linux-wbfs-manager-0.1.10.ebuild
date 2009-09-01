# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/linux-wbfs-manager/linux-wbfs-manager-0.1.10.ebuild,v 1.1 2009/09/01 18:21:32 vapier Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="WBFS manager for Linux using GTK+"
HOMEPAGE="http://code.google.com/p/linux-wbfs-manage/"
SRC_URI="http://linux-wbfs-manager.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/glib:2
	gnome-base/libglade:2.0"

S=${WORKDIR}/${PN}

src_prepare() {
	sed -i \
		-e '/^CFLAGS/s:= -O2:+= $(CPPFLAGS):' \
		-e '/^LDFLAGS/d' \
		Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin wbfs_gtk || die
	dodoc README
}
