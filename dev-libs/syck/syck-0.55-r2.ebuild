# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/syck/syck-0.55-r2.ebuild,v 1.1 2006/09/06 09:34:12 yuval Exp $

RUBY_OPTIONAL="yes"
inherit flag-o-matic distutils ruby

IUSE="python ruby"
DESCRIPTION="Syck is an extension for reading and writing YAML swiftly in popular scripting languages."
HOMEPAGE="http://whytheluckystiff.net/syck/"
SRC_URI="http://rubyforge.org/frs/download.php/4492/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="sys-libs/glibc
		ruby? ( dev-lang/ruby
			dev-ruby/racc
		)
		python? ( dev-lang/python )
	!=dev-libs/syck-0.55-r1"
RDEPEND="${DEPEND}"

src_compile() {
	append-flags -fPIC
	econf
	emake

	if use python; then
		pushd ext/python
		distutils_src_compile
		popd
	fi

	if use ruby; then
		pushd ext/ruby
		ruby_econf
		ruby_emake
		popd
	fi
}

src_install() {
	einstall

	if use python; then
		pushd ext/python
		distutils_src_install
		popd
	fi

	if use ruby; then
		pushd ext/ruby
		ruby_einstall
		popd
	fi
}
