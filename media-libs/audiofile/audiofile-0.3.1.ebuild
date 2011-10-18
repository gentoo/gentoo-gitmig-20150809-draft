# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/audiofile/audiofile-0.3.1.ebuild,v 1.4 2011/10/18 14:42:02 jer Exp $

EAPI=4

inherit autotools

DESCRIPTION="An elegant API for accessing audio files"
HOMEPAGE="http://www.68k.org/~michael/audiofile/"
SRC_URI="http://www.68k.org/~michael/${PN}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="static-libs"

DOCS=( ACKNOWLEDGEMENTS AUTHORS ChangeLog NEWS NOTES README TODO )

src_prepare() {
	sed -i -e "/^AM_CFLAGS =/s:-Werror ::" \
		libaudiofile/Makefile.am libaudiofile/modules/Makefile.am || die

	# Don't build examples
	sed -i -e "/^SRC_SUBDIRS/s: examples::" Makefile.am || die

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--enable-largefile
}

src_test() {
	emake -C test check
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete
}
