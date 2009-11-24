# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/figlet/figlet-222.ebuild,v 1.15 2009/11/24 16:27:14 darkside Exp $

inherit eutils bash-completion toolchain-funcs

MY_P=${P/-/}
DESCRIPTION="program for making large letters out of ordinary text"
HOMEPAGE="http://www.figlet.org/"
# Bug 35339 - add more fonts to figlet ebuild
# The fonts are available from the figlet site, but they don't
# have versions so we mirror them ourselves.
SRC_URI="ftp://ftp.figlet.org/pub/figlet/program/unix/${MY_P}.tar.gz
	mirror://gentoo/contributed-${PN}-221.tar.gz
	mirror://gentoo/ms-dos-${PN}-221.tar.gz"

LICENSE="AFL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd ~x86-macos"
IUSE=""

DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	cp "${WORKDIR}"/contributed/C64-fonts/*.flf fonts/ || die
	cp "${WORKDIR}"/contributed/bdffonts/*.flf fonts/ || die
	cp "${WORKDIR}"/ms-dos/*.flf fonts/ || die
	cp "${WORKDIR}"/contributed/*.flf fonts/ || die

	epatch "${FILESDIR}"/${P}-gentoo.diff
	sed -i \
		-e "s@CFLAGS = -g@CFLAGS = ${CFLAGS}@g" Makefile \
		|| die "sed failed"
}

src_compile() {
	tc-export CC
	emake CC="${CC}" clean all || die "emake failed"
}

src_install() {
	dodir /usr/bin /usr/share/man/man6 || die "dodir failed"
	chmod +x figlist showfigfonts
	use prefix || ED=${D}
	emake \
		DESTDIR="${ED}"/usr/bin \
		MANDIR="${ED}"/usr/share/man/man6 \
		DEFAULTFONTDIR="${ED}"/usr/share/figlet \
		install || die "make install failed"

	dodoc README figfont.txt
	dobashcompletion "${FILESDIR}"/figlet.bashcomp
}
