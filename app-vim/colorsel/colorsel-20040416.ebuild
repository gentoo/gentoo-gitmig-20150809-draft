# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/colorsel/colorsel-20040416.ebuild,v 1.1 2004/04/16 22:41:35 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: RGB / HSV color selector"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=927"
LICENSE="public-domain"
KEYWORDS="~sparc ~x86 ~mips"
RDEPEND=">=app-editors/gvim-6.2"

function src_unpack() {
	unpack ${A}

	# This plugin tests whether the GUI is present and barfs if not. We
	# don't want this, since we don't have a gvim-specific plugins
	# directory. Instead, we'll do a bit of sed-fu to make it just do
	# nothing in non-GUI mode.
	sed -i \
		-e "s:echoerr 'Color selector needs GUI':\" mmm, cookies':" \
		${S}/plugin/${PN}.vim \
		|| die "d'oh! sed magic didn't work, call an ambulance"
}
