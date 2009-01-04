# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grep/grep-2.5.3-r1.ebuild,v 1.4 2009/01/04 21:07:46 the_paya Exp $

inherit flag-o-matic eutils

DEB_VER="${PV}~dfsg-6"
DESCRIPTION="GNU regular expression matcher"
HOMEPAGE="http://www.gnu.org/software/grep/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2
	mirror://gentoo/${P}.tar.bz2
	mirror://debian/pool/main/g/grep/grep_${DEB_VER}.diff.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="nls pcre static"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	pcre? ( dev-libs/libpcre )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${WORKDIR}"/grep_${DEB_VER}.diff
	EPATCH_FORCE="yes" \
	EPATCH_SUFFIX="patch" \
	EPATCH_MULTI_MSG="Applying Debian patchset (${DEB_VER}) ..." \
	epatch ${P}~dfsg/debian/patches/
	epatch "${FILESDIR}"/${P}-yesno-test-fix.patch
	epatch "${FILESDIR}"/${P}-po-builddir-fix.patch
	epatch "${FILESDIR}"/${P}-nls.patch
	use static && append-ldflags -static
}

src_compile() {
	econf \
		--bindir=/bin \
		$(use_enable nls) \
		$(use_enable pcre perl-regexp) \
		$(use elibc_FreeBSD || echo --without-included-regex) \
		|| die "econf failed"

	use static || sed -i 's:-lpcre:-Wl,-Bstatic -lpcre -Wl,-Bdynamic:g' src/Makefile

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
