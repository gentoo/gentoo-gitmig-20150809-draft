# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/tcsh/tcsh-6.13-r1.ebuild,v 1.12 2005/07/09 13:29:17 swegener Exp $

inherit eutils

MY_P="${P}.00"
DESCRIPTION="Enhanced version of the Berkeley C shell (csh)"
HOMEPAGE="http://www.tcsh.org/"
SRC_URI="ftp://ftp.astron.com/pub/tcsh/${MY_P}.tar.gz
	mirror://gentoo/tcsh-complete"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE="perl"

RDEPEND="virtual/libc
	>=sys-libs/ncurses-5.1
	perl? ( dev-lang/perl )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${MY_P}.tar.gz

	cd ${S}

	epatch ${FILESDIR}/tcsh-6.13.00-utmp.patch
	epatch ${FILESDIR}/tcsh-6.13.00-dspmbyte.patch
	epatch ${FILESDIR}/tcsh-6.11.00-termcap.patch
	epatch ${FILESDIR}/tcsh-6.12.00-setpgrp.patch
	epatch ${FILESDIR}/tcsh-6.13.00-charset.patch
	epatch ${FILESDIR}/tcsh-6.13.00-iconv.patch
	epatch ${FILESDIR}/tcsh-6.13.00-glob.patch
	epatch ${FILESDIR}/tcsh-6.13.00-arch.patch
	epatch ${FILESDIR}/tcsh-6.13.00-fcntl.patch
	epatch ${FILESDIR}/tcsh-6.13.00-winchg.patch
	epatch ${FILESDIR}/tcsh-6.13.00-codeset.patch
	epatch ${FILESDIR}/tcsh-6.13.00-closem.patch
	epatch ${FILESDIR}/tcsh-6.13.00-cstr.patch
}

src_compile() {
	econf --prefix=/ || die "econf failed"
	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install install.man || die

	if use perl ; then
		perl tcsh.man2html || die
		dohtml tcsh.html/*.html
	fi

	dosym /bin/tcsh /bin/csh
	dodoc FAQ Fixes NewThings Ported README WishList Y2K

	insinto /etc
	newins ${FILESDIR}/csh.cshrc_new csh.cshrc
	newins ${FILESDIR}/csh.login_new csh.login

	insinto /etc/skel
	newins ${FILESDIR}/tcsh.config .tcsh.config

	insinto /etc/profile.d
	doins ${FILESDIR}/tcsh-settings ${FILESDIR}/tcsh-aliases ${FILESDIR}/tcsh-bindkey ${DISTDIR}/tcsh-complete
}
