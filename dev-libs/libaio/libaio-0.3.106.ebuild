# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libaio/libaio-0.3.106.ebuild,v 1.9 2006/07/12 04:35:53 nerdboy Exp $

inherit eutils multilib

DESCRIPTION="Asynchronous input/output library that uses the kernels native interface"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/andrea/libaio/"
# Rip out of src rpm that Redhat uses:
# http://download.fedora.redhat.com/pub/fedora/linux/core/development/SRPMS/
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 s390 x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	sed -i -e "s:/lib/:/$(get_libdir)/:g" src/Makefile
}

src_install() {
	make install prefix="${D}usr" libdir="${D}usr/$(get_libdir)" \
	    root=${D} || die "make install failed"
	doman man/*
	dodoc ChangeLog TODO COPYING

	# remove stuff provided by man-pages now
	rm "${D}"/usr/share/man/man3/aio_{cancel,error,fsync,read,return,suspend,write}.*
}
