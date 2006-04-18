# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grep/grep-2.5.1a.ebuild,v 1.7 2006/04/18 16:34:13 flameeyes Exp $

inherit flag-o-matic eutils

DESCRIPTION="GNU regular expression matcher"
HOMEPAGE="http://www.gnu.org/software/grep/grep.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2
	mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 m68k ~mips ppc ~ppc-macos ppc64 s390 sh ~sparc ~x86 ~x86-fbsd"
IUSE="build nls static"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix a weird sparc32 compiler bug
	echo "" >> src/dfa.h

	epatch "${FILESDIR}"/${PN}-2.5.1-manpage.patch
	epatch "${FILESDIR}"/${PN}-2.5.1-fgrep.patch
	epatch "${FILESDIR}"/${PN}-2.5.1-color.patch
	epatch "${FILESDIR}"/${PN}-2.5.1-bracket.patch
	epatch "${FILESDIR}"/${PN}-2.5.1-i18n.patch
	epatch "${FILESDIR}"/${PN}-2.5.1-oi.patch
	epatch "${FILESDIR}"/${PN}-2.5.1-restrict_arr.patch
	epatch "${FILESDIR}"/2.5.1-utf8-case.patch
	epatch "${FILESDIR}"/${PN}-2.5.1-perl-segv.patch #95495
	epatch "${FILESDIR}"/${PN}-2.5.1-fix-devices-skip.patch #113640
	epatch "${FILESDIR}"/${P}-nls.patch

	# retarded
	sed -i 's:__mempcpy:mempcpy:g' lib/*.c || die
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

pkg_postinst() {
	if has pcre ${USE} ; then
		ewarn "This grep ebuild no longer supports pcre.  If you want this"
		ewarn "functionality, please use 'pcregrep' from the libpcre package."
	fi
}
