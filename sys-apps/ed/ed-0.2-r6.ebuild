# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ed/ed-0.2-r6.ebuild,v 1.1 2005/01/10 17:01:04 vapier Exp $

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

	# This little autoconf line isn't critical.
	# It's only needed when you want to cross-compile.
	# Since ed is a system package, we don't want to 
	# force an autoconf DEPEND.
	if [[ ${CBUILD:-${CHOST}} != ${CHOST} ]] ; then
		chmod 755 configure #73575
		WANT_AUTOCONF=2.1 autoconf || die "autoconf failed"
	fi
}

src_compile() {
	tc-export CC RANLIB
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
