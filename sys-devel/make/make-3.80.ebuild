# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/make/make-3.80.ebuild,v 1.21 2004/07/17 00:32:07 mr_bones_ Exp $

inherit gnuconfig

DESCRIPTION="Standard tool to compile source trees"
HOMEPAGE="http://www.gnu.org/software/make/make.html"
SRC_URI="ftp://ftp.gnu.org/gnu/make/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390"
IUSE="nls static build uclibc"

DEPEND="virtual/libc
	nls? ( sys-devel/gettext )"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Detect mips and uclibc systems properly
	gnuconfig_update
}

src_compile() {
	econf \
		$(use_enable nls) \
		|| die

	if use static
	then
		emake LDFLAGS=-static || die
	else
		emake || die
	fi
}

src_install() {
	if use build
	then
		dobin make || die
	else
		make DESTDIR="${D}" install || die "make install failed"

		fperms 0755 /usr/bin/make
		dosym make /usr/bin/gmake

		dodoc AUTHORS ChangeLog NEWS README*
	fi
}
