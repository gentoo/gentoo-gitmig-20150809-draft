# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/libarchive/libarchive-2.6.1.ebuild,v 1.3 2009/01/26 04:39:28 vapier Exp $

EAPI=1

inherit eutils libtool toolchain-funcs

DESCRIPTION="BSD tar command"
HOMEPAGE="http://people.freebsd.org/~kientzle/libarchive"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz
	http://people.freebsd.org/~kientzle/libarchive/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="static acl xattr kernel_linux +bzip2 +lzma +zlib"

COMPRESS_LIBS_DEPEND="lzma? ( app-arch/lzma-utils )
		bzip2? ( app-arch/bzip2 )
		zlib? ( sys-libs/zlib )"

RDEPEND="!dev-libs/libarchive
	kernel_linux? (
		acl? ( sys-apps/acl )
		xattr? ( sys-apps/attr )
	)
	!static? ( ${COMPRESS_LIBS_DEPEND} )"
DEPEND="${RDEPEND}
	${COMPRESS_LIBS_DEPEND}
	kernel_linux? ( sys-fs/e2fsprogs
		virtual/os-headers )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-headers.patch
	elibtoolize
	epunt_cxx
}

src_compile() {
	local myconf

	if ! use static ; then
		myconf="--enable-bsdtar=shared --enable-bsdcpio=shared"
	fi

	econf --bindir=/bin \
		--enable-bsdtar --enable-bsdcpio \
		$(use_enable acl) $(use_enable xattr) \
		$(use_with zlib) \
		$(use_with bzip2 bz2lib) $(use_with lzma lzmadec) \
		${myconf} \
		--disable-dependency-tracking || die "econf failed."

	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	# Create tar symlink for FreeBSD
	if [[ ${CHOST} == *-freebsd* ]]; then
		dosym bsdtar /bin/tar
		dosym bsdtar.1 /usr/share/man/man1/tar.1
		# We may wish to switch to symlink bsdcpio to cpio too one day
	fi

	dodoc NEWS README
	dodir /$(get_libdir)
	mv "${D}"/usr/$(get_libdir)/*.so* "${D}"/$(get_libdir)
	gen_usr_ldscript libarchive.so
}
