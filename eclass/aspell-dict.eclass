# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/aspell-dict.eclass,v 1.17 2003/07/20 08:10:38 spyderous Exp $
#
# Author: Seemant Kulleen <seemant@gentoo.org>
#
# The aspell-dict eclass is designed to streamline the construction of
# ebuilds for the new aspell dictionaries (from gnu.org) which support
# aspell-0.50

ECLASS=aspell-dict
INHERITED="${INHERITED} ${ECLASS}"

EXPORT_FUNCTIONS src_compile src_install

#MY_P=${PN}-${PV%.*}-${PV#*.*.}
MY_P=${P%.*}-${PV##*.}
SPELLANG=${PN/aspell-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="${ASPELL_LANG} language dictionary for aspell"
HOMEPAGE="http://aspell.net"
SRC_URI="ftp://ftp.gnu.org/gnu/aspell/dict/${SPELLANG}/${MY_P}.tar.bz2"

DEPEND=">=app-text/aspell-0.50"
RDEPEND="$DEPEND"

SLOT="0"
KEYWORDS="x86 ppc sparc alpha mips hppa arm amd64"
PROVIDE="virtual/aspell-dict"


aspell-dict_src_compile() {
	./configure || die
	emake || die
}

aspell-dict_src_install() {

	make DESTDIR=${D} install || die

	dodoc Copyright README info
}
