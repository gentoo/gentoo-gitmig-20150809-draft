# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ed/ed-0.2-r4.ebuild,v 1.11 2004/12/06 05:44:29 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Your basic line editor"
HOMEPAGE="http://www.gnu.org/software/ed/"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/ed/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="virtual/libc
	sys-apps/texinfo"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-info-dir.patch
	epatch ${FILESDIR}/${PV}-mkstemp.patch
	WANT_AUTOCONF=2.1 autoconf || die "autoconf failed"
}

src_compile() {
	export CC="$(tc-getCC)" RANLIB="$(tc-getRANLIB)"
	# very old configure script ... econf wont work
	local myconf="--prefix=/ --host=${CHOST}"
	[[ -n ${CBUILD} ]] && myconf="${myconf} --build=${CBUILD}"
	[[ -n ${CTARGET} ]] && myconf="${myconf} --target=${CTARGET}"
	myconf="${myconf} ${EXTRA_ECONF}"
	echo "./configure ${myconf}"
	./configure ${myconf} || die
	emake AR="$(tc-getAR)" || die
}

src_install() {
	chmod 0644 ${S}/ed.info
	make \
		prefix=${D}/ \
		mandir=${D}/usr/share/man/man1 \
		infodir=${D}/usr/share/info \
		install || die
	dodoc ChangeLog NEWS POSIX README THANKS TODO
}
