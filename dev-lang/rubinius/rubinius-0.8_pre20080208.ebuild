# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/rubinius/rubinius-0.8_pre20080208.ebuild,v 1.1 2008/02/08 15:23:39 caleb Exp $

EAPI=1
EGIT_REPO_URI="git://git.rubini.us/code"

inherit multilib git

# Must go after inherit git
# This is the tree shaid that we want to grab
EGIT_TREE="f60fd914037838ac01032d85336675f0afd0964c"

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
	sed -ie "s:PREFIX=/usr/local:PREFIX=/usr:g" "${S}"/shotgun/vars.mk

	if use debug; then
		DEV=1 rake build
	else
		rake build
	fi
}

src_install() {
	LIBDIR=$(get_libdir)
	RDIR=/usr/${LIBDIR}/rubinius

	dodir ${RDIR}/shotgun
	cp -pR "${S}"/runtime "${D}"/${RDIR}
	cp -pR "${S}"/lib "${D}"/${RDIR}
	install shotgun/lib/librubinius-0.8.0.so "${D}"/usr/${LIBDIR}

	install shotgun/rubinius "${D}"/${RDIR}/shotgun
	install shotgun/rubinius.bin "${D}"/${RDIR}/shotgun
	install shotgun/gdb* "${D}"/${RDIR}/shotgun
	dosym ${RDIR}/shotgun/rubinius /usr/bin/rbx
}

src_test() {
	./bin/ci
}
