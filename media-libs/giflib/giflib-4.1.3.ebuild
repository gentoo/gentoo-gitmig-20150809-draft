# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/giflib/giflib-4.1.3.ebuild,v 1.2 2005/01/30 10:07:12 lanius Exp $

inherit gnuconfig

DESCRIPTION="Library to handle, display and manipulate GIF images"
HOMEPAGE="http://sourceforge.net/projects/libungif/"
SRC_URI="mirror://sourceforge/libungif/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa amd64 ~ia64 ~ppc64 ~ppc-macos"
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
	use gif || rm -rf "${D}/usr/bin" "${D}/usr/include/gif_lib.h"

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
