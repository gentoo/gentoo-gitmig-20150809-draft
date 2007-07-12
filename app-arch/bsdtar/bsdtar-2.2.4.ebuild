# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/bsdtar/bsdtar-2.2.4.ebuild,v 1.1 2007/07/12 17:04:57 uberlord Exp $

inherit eutils autotools toolchain-funcs flag-o-matic

MY_P="libarchive-${PV/_beta/b}"

DESCRIPTION="BSD tar command"
HOMEPAGE="http://people.freebsd.org/~kientzle/libarchive/"
SRC_URI="http://people.freebsd.org/~kientzle/libarchive/src/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="build static acl xattr"

RDEPEND="!dev-libs/libarchive
	kernel_linux? (
		acl? ( sys-apps/acl )
		xattr? ( sys-apps/attr )
	)
	!static? ( !build? (
		app-arch/bzip2
		sys-libs/zlib ) )"
DEPEND="${RDEPEND}
	kernel_linux? ( sys-fs/e2fsprogs
		virtual/os-headers )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/libarchive-2.1.9-static.patch
	epatch "${FILESDIR}"/libarchive-2.1.5-acl.patch

	eautoreconf
	epunt_cxx
}

src_compile() {
	local myconf

	if use static || use build ; then
		myconf="${myconf} --enable-static-bsdtar"
	else
		myconf="${myconf} --disable-static-bsdtar"
	fi

	# Upstream doesn't seem to care to fix the problems
	# and I don't want to continue running after them.
	append-flags -fno-strict-aliasing

	econf \
		--bindir=/bin \
		$(use_enable acl) \
		$(use_enable xattr) \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	# Create tar symlink for FreeBSD
	if [[ ${CHOST} == *-freebsd* ]]; then
		dosym bsdtar /bin/tar
		dosym bsdtar.1 /usr/share/man/man1/tar.1
	fi

	if use build; then
		rm -rf "${D}"/usr
		rm -rf "${D}"/lib/*.so*
		return 0
	fi

	dodir /$(get_libdir)
	mv "${D}"/usr/$(get_libdir)/*.so* "${D}"/$(get_libdir)
	gen_usr_ldscript libarchive.so
}
