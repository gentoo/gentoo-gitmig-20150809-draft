# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/recode/recode-3.6-r1.ebuild,v 1.22 2005/07/13 17:37:14 kito Exp $

inherit flag-o-matic eutils toolchain-funcs libtool

DESCRIPTION="Convert files between various character sets"
HOMEPAGE="http://www.gnu.org/software/recode/"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-debian.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc sparc x86 ppc64 ~ppc-macos"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}/${P}-debian.diff"

	if use ppc-macos; then
		epatch ${FILESDIR}/${P}-ppc-macos.diff
		cp ${S}/lib/error.c ${S}/lib/xstrdup.c ${S}/src/ || die "file copy failed"
		elibtoolize
		LDFLAGS="${LDFLAGS} -lgettextlib"
	fi
}

src_compile() {
	# gcc-3.2 crashes if we don't remove any -O?
	[[ ${ARCH} == "x86" && $(gcc-version) == "3.2" ]] && filter-flags -O?

	replace-cpu-flags pentium4 pentium3

	econf $(use_enable nls) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BACKLOG ChangeLog NEWS README THANKS TODO

	use ppc-macos && rm ${D}/usr/lib/charset.alias
}
