# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/storable/storable-0.7.2.ebuild,v 1.1 2010/04/07 12:42:05 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGES.txt README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Marshal Ruby classes into and out of multiple formats"
HOMEPAGE="http://solutious.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_URI="http://github.com/delano/${PN}/tarball/v${PV} -> ${PN}-git-${PV}.tgz"
S="${WORKDIR}/delano-${PN}-d582732"

ruby_add_bdepend test dev-ruby/tryouts

all_ruby_prepare() {
	mv bin examples || die
}

each_ruby_test() {
	${RUBY} -Ilib -S sergeant || die "tests failed"
}

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc examples/* || die
}
