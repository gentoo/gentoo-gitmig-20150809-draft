# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/colorgcc/colorgcc-1.3.2-r4.ebuild,v 1.3 2004/03/09 03:33:54 jhuebel Exp $

IUSE=""

inherit eutils

S="${WORKDIR}/${P}"
DESCRIPTION="Adds color to gcc output"
HOMEPAGE="http://www.mindspring.com/~jamoyers/software/"
SRC_URI="http://www.mindspring.com/~jamoyers/software/colorgcc/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~mips ~ppc ~amd64"

DEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo-one.patch
	epatch ${FILESDIR}/${P}-gentoo-two.patch
}

src_compile() {
	echo ">>> Nothing to compile"
}

src_install() {
	exeinto /usr/bin
	doexe colorgcc
	dodir /etc/colorgcc /usr/lib/colorgcc/bin
	insinto /etc/colorgcc
	doins colorgccrc
	einfo "Scanning for compiler front-ends"
	into /usr/lib/colorgcc/bin
	for a in gcc cc c++ g++ ${CHOST}-gcc ${CHOST}-c++ ${CHOST}-g++ ; do
		if [ -n "$(type -p ${a})" ]; then
			dosym /usr/bin/colorgcc /usr/lib/colorgcc/bin/${a}
		fi
	done

	dodoc COPYING CREDITS ChangeLog INSTALL
}

pkg_postinst() {
	einfo "If you have existing \$HOME/.colorgccrc files that set the location"
	einfo "of the compilers, you should remove those lines for maximum"
	einfo "flexibility.  The colorgcc script now knows how to pass the command"
	einfo "on to the next step in the PATH without manual tweaking, making it"
	einfo "easier to use with things like ccache and distcc on a conditional"
	einfo "basis.  You can tweak the /etc/colorgcc/colorgccrc file to change"
	einfo "the default settings for everyone (or copy this file as a basis for"
	einfo "a custom \$HOME/.colorgccrc file).  NOTE also that the symlinks for"
	einfo "colorgcc are now in the /usr/lib/colorgcc/bin dir NOT the"
	einfo "/usr/bin/wrapper dir.  You'll need to change any PATH settings that"
	einfo "referred to the old location."
}
