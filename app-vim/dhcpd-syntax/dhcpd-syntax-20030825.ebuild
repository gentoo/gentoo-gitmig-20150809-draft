# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/dhcpd-syntax/dhcpd-syntax-20030825.ebuild,v 1.5 2005/07/29 13:33:23 ka0ttic Exp $

inherit vim-plugin eutils

DESCRIPTION="vim plugin: syntax highlighting for dhcpd.conf"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=744"
LICENSE="as-is"
KEYWORDS="~alpha ~amd64 ia64 ~mips ~ppc ~ppc64 sparc x86"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides syntax highlighting for dhcpd.conf files."

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-multiple-addresses.patch
}
