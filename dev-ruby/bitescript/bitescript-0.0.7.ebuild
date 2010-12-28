# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/bitescript/bitescript-0.0.7.ebuild,v 1.1 2010/12/28 09:44:20 graaff Exp $

EAPI=2

USE_RUBY="jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.txt History.txt"

inherit ruby-fakegem eutils

DESCRIPTION="BiteScript is a Ruby DSL for generating Java bytecode and classes."
HOMEPAGE="http://kenai.com/projects/bitescript"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc examples/* || die
}
