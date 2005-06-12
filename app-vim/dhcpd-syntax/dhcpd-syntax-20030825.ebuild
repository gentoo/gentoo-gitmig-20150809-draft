# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/dhcpd-syntax/dhcpd-syntax-20030825.ebuild,v 1.4 2005/06/12 11:22:19 dholm Exp $

inherit vim-plugin eutils

DESCRIPTION="vim plugin: syntax highlighting for dhcpd.conf"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=744"
LICENSE="as-is"
KEYWORDS="~alpha ~amd64 ia64 ~ppc ~ppc64 sparc x86"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides syntax highlighting for dhcpd.conf files."

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-multiple-addresses.patch
}
