# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libevent/libevent-2.0.12.ebuild,v 1.4 2011/07/23 16:15:34 xarthisius Exp $

EAPI="2"

inherit autotools-utils libtool

MY_P="${P}-stable"

DESCRIPTION="A library to execute a function when a specific event occurs on a file descriptor"
HOMEPAGE="http://monkey.org/~provos/libevent/"
SRC_URI="mirror://sourceforge/levent/files/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="static-libs test"

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
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog
	use static-libs || remove_libtool_files
}
