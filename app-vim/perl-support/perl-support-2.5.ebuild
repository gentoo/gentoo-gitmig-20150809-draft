# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/perl-support/perl-support-2.5.ebuild,v 1.3 2005/06/29 12:16:56 mcummings Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: Perl-IDE - Write and run Perl scripts using menus and hotkeys"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=556"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="as-is"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""
RESTRICT=nomirror

VIM_PLUGIN_HELPTEXT="This plugin provides a Perl IDE in vim."

