# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libungif/libungif-4.1.0.1b.ebuild,v 1.6 2004/02/06 22:31:46 vapier Exp $

inherit libtool

REAL_P=${P/.1b/b1}
DESCRIPTION="A library for reading and writing gif images without LZW compression"
HOMEPAGE="http://prtr-13.ucsc.edu/~badger/software/libungif/index.shtml"
SRC_URI="mirror://gentoo/${REAL_P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 ppc64"
IUSE="X gif"

RDEPEND="X? ( virtual/x11 )"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.58"

S=${WORKDIR}/${REAL_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/libungif-CVS.patch
	epatch ${FILESDIR}/libungif-4.1.0-stdarg.patch
}

src_compile() {
	elibtoolize || die
	export WANT_AUTOCONF=2.5

	local myconf
	use alpha \
		&& myconf="${myconf} --host=alpha-unknown-linux-gnu"
	econf `use_with X x` ${myconf} || die
	emake || die
}

src_install() {
	make prefix=${D}/usr install || die

	use gif && rm -rf ${D}/usr/bin

	dodoc AUTHORS BUGS COPYING ChangeLog NEWS ONEWS
	dodoc UNCOMPRESSED_GIF README TODO
	dodoc doc/*.txt
	dohtml -r doc
}

pkg_postinst() {
	if [ `use gif` ] ; then
		einfo "You had the gif USE flag set, so it is assumed that you want"
		einfo "the binary from giflib instead.  Please make sure you have"
		einfo "giflib emerged.  Otherwise, unset the gif flag and remerge this"
	else
		einfo "You did not have the gif USE flag, so your gif binary is being"
		einfo "provided by this package.  If you would rather use the binary"
		einfo "from giflib, please set the gif USE flag, and re-emerge both"
		einfo "this and giflib"
	fi
}
