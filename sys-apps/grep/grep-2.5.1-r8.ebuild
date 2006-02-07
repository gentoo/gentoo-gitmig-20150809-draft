# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grep/grep-2.5.1-r8.ebuild,v 1.13 2006/02/07 01:37:15 vapier Exp $

inherit flag-o-matic eutils

DESCRIPTION="GNU regular expression matcher"
HOMEPAGE="http://www.gnu.org/software/grep/grep.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ~ppc-macos ppc64 s390 sh sparc x86"
IUSE="build nls static"

RDEPEND=""
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix a weird sparc32 compiler bug
	echo "" >> src/dfa.h

	epatch "${FILESDIR}"/${P}-manpage.patch
	epatch "${FILESDIR}"/${P}-fgrep.patch
	epatch "${FILESDIR}"/${P}-bracket.patch
	epatch "${FILESDIR}"/${P}-i18n.patch
	epatch "${FILESDIR}"/${P}-oi.patch
	epatch "${FILESDIR}"/${P}-restrict_arr.patch
	epatch "${FILESDIR}"/${PV}-utf8-case.patch
	epatch "${FILESDIR}"/${P}-perl-segv.patch #95495
	epatch "${FILESDIR}"/${P}-libintl.patch #92586

	# uclibc does not suffer from this glibc bug.
	use elibc_uclibc || epatch "${FILESDIR}"/${PV}-tests.patch
}

src_compile() {
	if use static ; then
		append-flags -static
		append-ldflags -static
	fi

	econf \
		--bindir=/bin \
		$(use_enable nls) \
		--disable-perl-regexp \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# Override the default shell scripts... grep knows how to act
	# based on how it's called
	ln -sfn grep "${D}"/bin/egrep || die "ln egrep failed"
	ln -sfn grep "${D}"/bin/fgrep || die "ln fgrep failed"

	if use build ; then
		rm -r "${D}"/usr/share
	else
		dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	fi
}
