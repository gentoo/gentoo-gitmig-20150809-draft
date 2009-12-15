# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rdoc/rdoc-2.4.3.ebuild,v 1.1 2009/12/15 14:41:16 flameeyes Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC="doc"

inherit ruby-fakegem

DESCRIPTION="An extended version of the RDoc library from Ruby 1.8"
HOMEPAGE="http://rubyforge.org/projects/${PN}/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tgz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

all_ruby_install() {
	for bin in rdoc ri; do
		ruby_fakegem_binwrapper $bin $bin-2
	done

	dodoc {History,Manifest,README,RI}.txt || die

	if use doc; then
		pushd doc
		dohtml -r * || die
		popd
	fi
}
