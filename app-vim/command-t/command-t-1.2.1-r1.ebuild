# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/command-t/command-t-1.2.1-r1.ebuild,v 1.2 2011/07/22 01:24:33 radhermit Exp $

EAPI="4"
USE_RUBY="ruby18 ruby19"

inherit vim-plugin ruby-ng

DESCRIPTION="vim plugin: fast file navigation for vim"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=3025
	https://wincent.com/products/command-t"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="command-t.txt"

RDEPEND="|| ( app-editors/vim[ruby] app-editors/gvim[ruby] )"

each_ruby_configure() {
	cd ruby/${PN}
	${RUBY} extconf.rb || die "extconf.rb failed"
}

each_ruby_compile() {
	cd ruby/${PN}
	emake
	rm -f *.o *.c *.h *.log extconf.rb depend Makefile
}

each_ruby_install() {
	local sitelibdir=$(ruby_rbconfig_value "sitelibdir")
	insinto ${sitelibdir}/${PN}
	doins -r ruby/${PN}/*
	fperms 0775 ${sitelibdir}/${PN}/ext.so
}

all_ruby_install() {
	rm -rf ruby
	vim-plugin_src_install
}
