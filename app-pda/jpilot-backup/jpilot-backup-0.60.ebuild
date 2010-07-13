# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/jpilot-backup/jpilot-backup-0.60.ebuild,v 1.1 2010/07/13 13:49:28 ssuominen Exp $

EAPI=2
inherit multilib

DESCRIPTION="Backup plugin for jpilot"
HOMEPAGE="http://www.jlogday.com/code/jpilot-backup/index.html"
SRC_URI="http://www.jlogday.com/code/jpilot-backup/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.18.9
	>=app-pda/pilot-link-0.12.3
	>=app-pda/jpilot-0.99.9
	sys-libs/gdbm"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
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
