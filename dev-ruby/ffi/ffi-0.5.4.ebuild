# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ffi/ffi-0.5.4.ebuild,v 1.1 2010/01/31 14:35:47 flameeyes Exp $

EAPI=2

# jruby → unneeded, this is part of the standard JRuby distribution,
# and would just install a dummy
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_TASK_DOC="doc:rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Ruby extension for programmatically loading dynamic libraries"
HOMEPAGE="http://wiki.github.com/ffi/ffi"

SRC_URI="http://github.com/ffi/ffi/tarball/0.5.4 -> ${PN}-git-${PV}.tgz"

S="${WORKDIR}/ffi-ffi-57b5d81"

IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}-rakefile.patch
}

each_ruby_compile() {
	${RUBY} -S rake compile || die "compile failed"
}

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc samples/* || die
}
