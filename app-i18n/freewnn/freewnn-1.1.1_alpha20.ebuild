# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/freewnn/freewnn-1.1.1_alpha20.ebuild,v 1.4 2004/02/16 22:31:42 agriffis Exp $

MY_P="FreeWnn-${PV/_alpha/-a0}"

DESCRIPTION="Network-Extensible Kana-to-Kanji Conversion System"
HOMEPAGE="http://www.freewnn.org/"
SRC_URI="ftp://ftp.freewnn.org/pub/FreeWnn/alpha/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha ia64"
IUSE="X ipv6"

DEPEND="virtual/glibc
	X? ( virtual/x11 )"

S="${WORKDIR}/FreeWnn-1.10-pl020"

src_unpack() {
	unpack ${A}

	#Change WNNOWNER to root so we don't need to add wnn user
	mv ${S}/makerule.mk.in ${T}
	sed -e "s/WNNOWNER = wnn/WNNOWNER = root/" \
		${T}/makerule.mk.in > ${S}/makerule.mk.in
}

src_compile() {
	econf \
		--disable-cWnn \
		--disable-kWnn \
		--without-termcap \
		`use_with X x` \
		`use_with ipv6` || die "./configure failed"

	emake || die
	#make || die
}

src_install () {
	# install executables, libs ,dictionaries
	make DESTDIR=${D} install || die "installation failed"
	# install man pages
	make DESTDIR=${D} install.man || die "installation of manpages failed"
	# install docs
	dodoc ChangeLog* INSTALL* CONTRIBUTORS
	# install rc script
	exeinto /etc/init.d ; newexe ${FILESDIR}/freewnn.initd freewnn
}
