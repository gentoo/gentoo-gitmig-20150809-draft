# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libungif/libungif-4.1.0.1b.ebuild,v 1.16 2004/11/06 08:50:27 usata Exp $

inherit eutils libtool

REAL_P=${P/.1b/b1}
DESCRIPTION="A library for reading and writing gif images without LZW compression"
HOMEPAGE="http://prtr-13.ucsc.edu/~badger/software/libungif/index.shtml"
SRC_URI="mirror://gentoo/${REAL_P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64"
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

	automake --add-missing
}

src_compile() {
	elibtoolize || die

	local myconf
	use alpha && myconf="${myconf} --host=alpha-unknown-linux-gnu"
	econf `use_with X x` ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	use gif && rm -rf ${D}/usr/bin

	dodoc AUTHORS BUGS COPYING ChangeLog NEWS ONEWS UNCOMPRESSED_GIF \
		README TODO doc/*.txt || die "dodoc failed"
	dohtml -r doc || die "dohtml failed"
}

pkg_postinst() {
	if use gif ; then
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

src_test() {
	if has_version 'media-gfx/xv' ; then
		if [ -z "$DISPLAY" ] || ! (/usr/X11R6/bin/xhost &>/dev/null) ; then
			ewarn
			ewarn "You are not authorised to conntect to X server to make check."
			ewarn "Disabling make check."
			ewarn
			epause; ebeep; epause
		else
			make check || die "make check failed"
		fi
	else
		ewarn
		ewarn "You need media-gfx/xv to run src_test for this package."
		ewarn
		epause; ebeep; epause
	fi
}
