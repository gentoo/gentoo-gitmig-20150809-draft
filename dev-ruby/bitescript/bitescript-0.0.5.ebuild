# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/bitescript/bitescript-0.0.5.ebuild,v 1.1 2010/02/15 23:38:10 flameeyes Exp $

EAPI=2

USE_RUBY="jruby"

RUBY_FAKGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOC_DIR="doc"
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
