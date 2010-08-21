# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/jpilot-backup/jpilot-backup-0.60.ebuild,v 1.3 2010/08/21 14:12:04 tomjbe Exp $

EAPI=2
inherit flag-o-matic multilib

DESCRIPTION="Backup plugin for jpilot"
HOMEPAGE="http://www.jlogday.com/code/jpilot-backup/index.html"
SRC_URI="http://www.jlogday.com/code/jpilot-backup/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.18.9
	>=app-pda/pilot-link-0.12.3
	>=app-pda/jpilot-0.99.9
	sys-libs/gdbm"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	append-cppflags -DENABLE_GTK2
	econf \
		--enable-gtk2
}

src_install() {
	emake \
		DESTDIR="${D}" \
		libdir="/usr/$(get_libdir)/jpilot/plugins" \
		install || die

	dodoc ChangeLog CREDITS README* TODO

	find "${D}" -name '*.la' -delete
}
