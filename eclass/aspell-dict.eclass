# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/aspell-dict.eclass,v 1.21 2003/11/18 23:46:30 agriffis Exp $
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

RDEPEND=">=app-text/aspell-0.50"

SLOT="0"
KEYWORDS="x86 ppc sparc alpha mips hppa arm amd64 ia64"
PROVIDE="virtual/aspell-dict"


aspell-dict_src_compile() {
	./configure || die
	emake || die
}

aspell-dict_src_install() {

	make DESTDIR=${D} install || die

	for doc in Copyright README info; do
		[ -s "$doc" ] && dodoc $doc
	done
}
