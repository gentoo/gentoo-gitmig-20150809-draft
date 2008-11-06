# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libaio/libaio-0.3.107.ebuild,v 1.1 2008/11/06 23:51:44 vapier Exp $

inherit eutils multilib toolchain-funcs

DESCRIPTION="Asynchronous input/output library that uses the kernels native interface"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/andrea/libaio/ http://lse.sourceforge.net/io/aio.html"
# Rip out of src rpm that Redhat uses:
# http://download.fedora.redhat.com/pub/fedora/linux/core/development/source/SRPMS/
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~s390 ~x86"
IUSE=""
RESTRICT="test"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-sparc.patch
	epatch "${FILESDIR}"/${P}-install-to-slash.patch
	epatch "${FILESDIR}"/${PN}-0.3.106-build.patch
	sed -i "/^libdir=/s:lib$:$(get_libdir):" src/Makefile
}

src_compile() {
	tc-export CC
	emake || die "emake failed"
}

src_test() {
	cd "${S}"/harness
	mkdir testdir
	emake check prefix="${S}/src" libdir="${S}/src"
}

src_install() {
	emake install DESTDIR="${D}" || die
	doman man/*
	dodoc ChangeLog TODO

	# remove stuff provided by man-pages now
	rm "${D}"usr/share/man/man3/aio_{cancel,error,fsync,read,return,suspend,write}.*
}
