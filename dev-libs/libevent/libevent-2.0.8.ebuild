# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libevent/libevent-2.0.8.ebuild,v 1.1 2010/10/15 15:15:46 jer Exp $

EAPI="2"

inherit libtool

MY_P="${P}-rc"

DESCRIPTION="A library to execute a function when a specific event occurs on a file descriptor"
HOMEPAGE="http://monkey.org/~provos/libevent/"

#	http://monkey.org/~provos/${MY_P}.tar.gz
SRC_URI="
	mirror://sourceforge/levent/files/${MY_P}.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="static-libs test"

DEPEND=""
RDEPEND="!<=dev-libs/9libs-1.0"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# don't waste time building tests/samples
	sed -i \
		-e 's|^\(SUBDIRS =.*\)sample test\(.*\)$|\1\2|' \
		Makefile.in || die "sed Makefile.in failed"

	elibtoolize
}

src_configure() {
	econf $(use_enable static-libs static) || die "econf"
}

src_test() {
	emake -C test check | tee "${T}"/tests
	grep FAILED "${T}"/tests &>/dev/null && die "1 or more tests failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog
}
