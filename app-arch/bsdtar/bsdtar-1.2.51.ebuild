# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/bsdtar/bsdtar-1.2.51.ebuild,v 1.1 2006/03/19 20:58:43 flameeyes Exp $

inherit eutils flag-o-matic libtool

DESCRIPTION="BSD tar command"
HOMEPAGE="http://people.freebsd.org/~kientzle/libarchive/"
SRC_URI="http://people.freebsd.org/~kientzle/libarchive/src/libarchive-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc-macos ~x86"
IUSE="build static"

RDEPEND="!dev-libs/libarchive"
DEPEND="kernel_linux? ( sys-fs/e2fsprogs
	virtual/os-headers )"

S="${WORKDIR}/libarchive-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}

	elibtoolize
	epunt_cxx
}

src_compile() {
	if ! use userland_Darwin; then
		( use static || use build ) && append-ldflags -static
	fi

	econf --bindir=/bin || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install

	# Create tar symlink for FreeBSD
	if [[ ${CHOST} == *-freebsd* ]]; then
		dosym bsdtar /bin/tar
		dosym bsdtar.1.gz /usr/share/man/man1/tar.1.gz
	fi

	if [[ ${CHOST} != *-darwin* ]]; then
		dodir /$(get_libdir)
		mv ${D}/usr/$(get_libdir)/*.so* ${D}/$(get_libdir)
		gen_usr_ldscript libarchive.so
	fi
}
