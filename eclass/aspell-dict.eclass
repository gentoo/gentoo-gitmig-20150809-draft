# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/aspell-dict.eclass,v 1.30 2004/10/03 22:13:56 arj Exp $
#
# Author: Seemant Kulleen <seemant@gentoo.org>
#
# The aspell-dict eclass is designed to streamline the construction of
# ebuilds for the new aspell dictionaries (from gnu.org) which support
# aspell-0.50. Support for aspell-0.60 has been added by Sergey Ulanov.

ECLASS=aspell-dict
INHERITED="${INHERITED} ${ECLASS}"

EXPORT_FUNCTIONS src_compile src_install

#MY_P=${PN}-${PV%.*}-${PV#*.*.}
MY_P=${P%.*}-${PV##*.}
MY_P=aspell${ASPOSTFIX}-${MY_P/aspell-/}
SPELLANG=${PN/aspell-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="${ASPELL_LANG} language dictionary for aspell"
HOMEPAGE="http://aspell.net"
SRC_URI="ftp://ftp.gnu.org/gnu/aspell/dict/${SPELLANG}/${MY_P}.tar.bz2"

IUSE=""
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64"

if [ x${ASPOSTFIX} = x6 ] ; then
	RDEPEND=">=app-text/aspell-0.60
		sys-apps/which"
else
	RDEPEND=">=app-text/aspell-0.50
		sys-apps/which"
fi

PROVIDE="virtual/aspell-dict"

aspell-dict_src_compile() {
	echo `pwd`
	./configure || die
	emake || die
}

aspell-dict_src_install() {
	make DESTDIR=${D} install || die

	for doc in README info ; do
		[ -s "$doc" ] && dodoc $doc
	done
}
