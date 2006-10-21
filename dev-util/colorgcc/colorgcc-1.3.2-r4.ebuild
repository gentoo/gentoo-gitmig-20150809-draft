# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/colorgcc/colorgcc-1.3.2-r4.ebuild,v 1.12 2006/10/21 13:38:27 stefaan Exp $

IUSE=""

inherit eutils

DESCRIPTION="Adds color to gcc output"
HOMEPAGE="http://www.mindspring.com/~jamoyers/software/"
SRC_URI="http://www.mindspring.com/~jamoyers/software/colorgcc/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ~hppa ~mips ppc ~ppc-macos sparc x86"

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
	echo
	einfo "If you have existing \$HOME/.colorgccrc files that set the location"
	einfo "of the compilers, you should remove those lines for maximum"
	einfo "flexibility.  The colorgcc script now knows how to pass the command"
	einfo "on to the next step in the PATH without manual tweaking, making it"
	einfo "easier to use with things like ccache and distcc on a conditional"
	einfo "basis.  You can tweak the /etc/colorgcc/colorgccrc file to change"
	einfo "the default settings for everyone (or copy this file as a basis for"
	einfo "a custom \$HOME/.colorgccrc file)."
	einfo
	einfo "NOTE: the symlinks for colorgcc are now located in"
	einfo "/usr/lib/colorgcc/bin *NOT* /usr/bin/wrappers.  You'll need to"
	einfo "change any PATH settings that referred to the old location."
	echo
	# portage won't delete the old symlinks for users that are upgrading
	# because the old symlinks still point to /usr/bin/colorgcc which exists...
	[ -d ${ROOT}/usr/bin/wrappers ] && rm -fr ${ROOT}/usr/bin/wrappers
}
