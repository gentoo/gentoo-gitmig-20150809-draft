# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/jpilot-backup/jpilot-backup-0.53.ebuild,v 1.6 2010/07/13 14:07:18 ssuominen Exp $

inherit multilib

DESCRIPTION="Backup plugin for jpilot"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.jlogday.com/code/jpilot-backup/index.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6.10-r1
	>=app-pda/pilot-link-0.12.2
	>=app-pda/jpilot-0.99.9
	sys-libs/gdbm"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf --enable-gtk2 || die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	make install DESTDIR="${D}" \
		libdir=/usr/$(get_libdir)/jpilot/plugins \
		|| die "install failed"
}
