# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/giflib/giflib-4.1.0-r3.ebuild,v 1.31 2004/11/23 11:32:36 usata Exp $

inherit gnuconfig eutils

DESCRIPTION="Library to handle, display and manipulate GIF images"
HOMEPAGE="http://prtr-13.ucsc.edu/~badger/software/libungif/index.shtml"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/libs/giflib/${P}.tar.gz
	 ftp://prtr-13.ucsc.edu/pub/libungif/${P}.tar.gz"

LICENSE="|| ( as-is BSD )"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64"
IUSE="X gif"

DEPEND="X? ( virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
	# The library it tries to create is like 12 bytes, which is obviously bogus,
	# updating libtool/autoconf fixes this!
	if [ "${ARCH}" = "ppc64" ] ; then
		libtoolize -c -f
		aclocal
		autoconf
	fi
}

src_compile() {
	econf `use_with X x` || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	# if gif is not in USE, then ungif is preferred
	use gif || rm -rf "${D}/usr/bin"

	dodoc AUTHORS BUGS ChangeLog NEWS ONEWS PATENT_PROBLEMS \
		README TODO doc/*.txt || die "dodoc failed"
	dohtml -r doc || die "dohtml failed"
}

pkg_postinst() {
	if use gif ; then
		einfo "You had the gif USE flag set, so the binary from this library"
		einfo "is your gif binary.  If you would prefer to use the binary from"
		einfo "the ungif library, please unset the gif USE toggle, and remerge"
		einfo "both this and libungif"
	else
		einfo "You did not have the gif USE toggle set, so the binary from"
		einfo "the libungif package is assumed to be your gif binary. Please"
		einfo "make sure that you have libungif emerged."
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
		ewarn "You need media-gfx/xv to run the tests for this package."
		ewarn "Disabling make check."
		ewarn
		epause; ebeep; epause
	fi
}
