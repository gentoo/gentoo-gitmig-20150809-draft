# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/rubinius/rubinius-0.9.0.ebuild,v 1.2 2008/07/20 06:28:26 mr_bones_ Exp $

EAPI=1
EGIT_REPO_URI="git://git.rubini.us/code"

inherit multilib git

# Must go after inherit git
# This is the tree shaid that we want to grab
EGIT_TREE="tags/v0.9.0"

DESCRIPTION="An alternative ruby interpreter"
HOMEPAGE="http://rubini.us"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"

RDEPEND=">=dev-lang/ruby-1.8.6_p110:1.8
	dev-ruby/rubygems"
DEPEND="sys-devel/bison
	dev-util/pkgconfig
	dev-ruby/rake
	${RDEPEND}"

src_compile() {
	export PREFIX="${S}"/usr

	if use debug; then
		DEV=1 rake build
	else
		rake build
	fi
}

src_install() {
	mkdir -p "${D}/usr/lib"
	install -c lib/librubinius-0.9.0.so "${D}/usr/lib"

	mkdir -p "${D}/usr/bin"
	install -c bin/rbx "${D}/usr/bin"

	export PREFIX="${D}"/usr
	rake install
}

src_test() {
	./bin/ci
}
