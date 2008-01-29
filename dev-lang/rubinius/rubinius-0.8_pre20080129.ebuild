# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/rubinius/rubinius-0.8_pre20080129.ebuild,v 1.1 2008/01/29 18:42:20 caleb Exp $

inherit multilib

EAPI=1

DESCRIPTION="An alternative ruby interpreter"
HOMEPAGE="http://rubini.us"

GIT_COMMIT="036797603833bdb20468134d242b44fae9791477"

SRC_URI="mirror://gentoo/rubinius-${GIT_COMMIT}.tar.gz"
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

S=${WORKDIR}/code

src_unpack() {
	unpack ${A}
	sed -ie "s:PREFIX=/usr/local:PREFIX=/usr:g" "${S}":/shotgun/vars.mk
}

src_compile() {
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
