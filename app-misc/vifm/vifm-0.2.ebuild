# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/vifm/vifm-0.2.ebuild,v 1.2 2003/05/21 15:26:27 latexer Exp $

DESCRIPTION="Console file manager with vi/vim-like keybindings"
HOMEPAGE="http://vifm.sourceforge.net/"
SRC_URI="mirror://sourceforge/vifm/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""
DEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	cd ${S}
	mv -f Makefile.in ${T}
	sed -e "s:(datadir)/@PACKAGE@:(datadir)/${P}:" \
		${T}/Makefile.in > Makefile.in

	cd ${S}/src
	mv -f Makefile.in ${T}
	sed -e "s:(datadir)/@PACKAGE@:(datadir)/${P}:" \
		${T}/Makefile.in > Makefile.in
	
	mv -f config.c ${T}
	sed -e "s:/usr/local/share/vifm:/usr/share/${P}:g" \
		${T}/config.c > config.c
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc INSTALL AUTHORS TODO README 
}
pkg_postinst() {
	einfo "To use vim to view the vifm help, copy /usr/share/${P}/vifm.txt"
	einfo "to ~/.vim/doc/ and run ':helptags ~/.vim/doc' in vim"
	einfo "Then edit ~/vifm/vifmrc${PV} and set USE_VIM_HELP=1"
	einfo ""
	einfo "To use the vifm plugin in vim, copy /usr/share/${P}/vifm.vim to"
	einfo "/usr/share/vim/vim61/"
}
