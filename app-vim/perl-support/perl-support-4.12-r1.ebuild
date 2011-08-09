# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/perl-support/perl-support-4.12-r1.ebuild,v 1.2 2011/08/09 19:23:14 xarthisius Exp $

EAPI=4

inherit vim-plugin eutils

DESCRIPTION="vim plugin: Perl-IDE - Write and run Perl scripts using menus and hotkeys"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=556"
SRC_URI="https://github.com/vim-scripts/${PN}.vim/tarball/${PV} -> ${P}.tar.gz"
LICENSE="as-is"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

VIM_PLUGIN_HELPFILES="perlsupport"

RDEPEND="dev-perl/Perl-Tags
	dev-perl/Perl-Critic"

src_unpack() {
	unpack ${A}
	mv *-${PN}.vim-* "${S}"
}

src_prepare() {
	# Don't set tabstop and shiftwidth
	sed -i -e '/=4/s/^/"/' ftplugin/perl.vim

	epatch "${FILESDIR}"/${P}-local-templates.patch
}

src_install() {
	dodoc doc/{ChangeLog,perl-hot-keys.pdf}
	rm doc/{ChangeLog,perl-hot-keys.*,pmdesc3.text}
	vim-plugin_src_install
}
