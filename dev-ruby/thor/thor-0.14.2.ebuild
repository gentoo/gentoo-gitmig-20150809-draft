# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/thor/thor-0.14.2.ebuild,v 1.2 2010/10/20 11:06:35 flameeyes Exp $

EAPI=2
USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc README.md"
RUBY_FAKEGEM_BINWRAP="thor"

inherit ruby-fakegem

DESCRIPTION="A scripting framework that replaces rake and sake"
HOMEPAGE="http://github.com/wycats/thor"

SRC_URI="http://github.com/wycats/${PN}/tarball/v${PV} -> ${PN}-git-${PV}.tgz"
S="${WORKDIR}/wycats-${PN}-*"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

ruby_add_bdepend "
	test? ( dev-ruby/fakeweb )
	doc? ( dev-ruby/rdoc )"

all_ruby_prepare() {
	einfo $(pwd)
	# Having VERSION in the docs makes the rdoc generation fail.
	sed -i -e '/EXTRA_RDOC_FILES/s/"VERSION", //' Thorfile || die
}

all_ruby_compile() {
	einfo $(pwd)
	if use doc; then
		ruby -Ilib bin/thor rdoc || die "RDoc generation failed"
	fi
}

each_ruby_test() {
	${RUBY} -Ilib/ bin/thor spec || die "Tests for ${RUBY} failed"
}
