# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/tcsh/tcsh-6.12-r2.ebuild,v 1.13 2004/10/04 23:37:11 pvdabeel Exp $

inherit eutils

MY_P="${PN}-${PV}.00"
DESCRIPTION="Enhanced version of the Berkeley C shell (csh)"
HOMEPAGE="http://www.tcsh.org/"
SRC_URI="ftp://ftp.astron.com/pub/tcsh/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64"
IUSE="cjk perl"

RDEPEND="virtual/libc
	>=sys-libs/ncurses-5.1
	perl? ( dev-lang/perl )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-tc.os.h-gentoo.diff
	use cjk && epatch ${FILESDIR}/tcsh_enable_kanji.diff
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
	doins ${FILESDIR}/tcsh-settings ${FILESDIR}/tcsh-aliases ${FILESDIR}/tcsh-bindkey ${FILESDIR}/tcsh-complete
}
