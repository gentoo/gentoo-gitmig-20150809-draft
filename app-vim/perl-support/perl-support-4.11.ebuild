# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/perl-support/perl-support-4.11.ebuild,v 1.1 2011/04/22 04:50:26 radhermit Exp $

EAPI=3

inherit vim-plugin

DESCRIPTION="vim plugin: Perl-IDE - Write and run Perl scripts using menus and hotkeys"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=556"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=15492 -> ${P}.zip"
LICENSE="as-is"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

VIM_PLUGIN_HELPFILES="perlsupport"

DEPEND="app-arch/unzip"
RDEPEND="dev-perl/Perl-Tags
	dev-perl/Perl-Critic"

S="${WORKDIR}"

src_prepare() {
	# Don't set tabstop and shiftwidth
	sed -i -e '/=4/s/^/"/' ftplugin/perl.vim
}
