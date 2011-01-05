# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dos2unix/dos2unix-5.1.1.ebuild,v 1.3 2011/01/05 16:10:50 hwoarang Exp $

EAPI="3"

inherit toolchain-funcs

DESCRIPTION="Convert DOS or MAC text files to UNIX format or vice versa"
HOMEPAGE="http://www.xs4all.nl/~waterlan/dos2unix.html http://sourceforge.net/projects/dos2unix/"
SRC_URI="
	http://www.xs4all.nl/~waterlan/${PN}/${P}.tar.gz
	mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~sparc64-solaris"
IUSE="nls"

DEPEND="virtual/libintl"
RDEPEND="
	${DEPEND}
	!app-text/hd2u
	!app-text/unix2dos"

src_prepare() {
	sed \
		-e '/^LDFLAGS/s|=|+=|' \
		-e '/^CC/s|=|?=|' \
		-e '/CFLAGS_OS \+=/d' \
		-e '/LDFLAGS_EXTRA \+=/d' \
		-i "${S}"/Makefile || die
	tc-export CC
}

lintl() {
	# same logic as from virtual/libintl
	use !elibc_glibc && use !elibc_uclibc && echo "-lintl"
}

src_compile() {
	emake prefix="${EPREFIX}"/usr \
		$(use nls && echo "LDFLAGS_EXTRA=$(lintl)" || echo "ENABLE_NLS=") \
		|| die
}

src_install() {
	emake DESTDIR="${D}" prefix="${EPREFIX}"/usr \
		$(use nls || echo "ENABLE_NLS=") install \
		|| die "emake install failed"
}
