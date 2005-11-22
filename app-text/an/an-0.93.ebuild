# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/an/an-0.93.ebuild,v 1.1 2005/11/22 01:37:56 jer Exp $

DESCRIPTION="Anagram generator with dictionary lookup"
HOMEPAGE="none"
SRC_URI="http://bindist.finkmirrors.net/bindist/dists/fink-0.8.0/main/source/games/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~hppa ~x86"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="sys-apps/miscfiles"

inherit toolchain-funcs

src_unpack() {
	unpack ${A}
	cd ${S}
	# Patching an to use tc and custom CFLAGS:
	sed -i -e "s:gcc:$(tc-getCC):" \
		   -e "s:CFLAGS:#CFLAGS:" \
		   Makefile lib/Makefile || die
	# sys-apps/miscfiles doesn't have /usr/dict/words:
	einfo "Patching an to use /usr/share/dict/words"
	sed -i \
		-e 's:\/usr\/dict\/words:\/usr\/share\/dict\/words:' \
		an.6 an.c \
		an.man.txt \
		README || die
}

src_install() {
	dobin ${PN}
	doman ${PN}.6
	dodoc ChangeLog DICTIONARY EXAMPLE.ANAGRAMS HINTS README TODO
}

pkg_postinst() {
	ewarn "If you merged sys-apps/miscfiles with USE=minimal,"
	ewarn "an will NOT work properly, as /usr/share/dict/words"
	ewarn "will then be a symlink to a gzipped file. an currently"
	ewarn "does not support gzipped dictionary files and will"
	ewarn "only produce garbage."
	ewarn "Do 'USE=-minimal emerge sys-apps/miscfiles', or run an"
	ewarn "with the -d /path/to/dictionary option, perhaps using"
	ewarn "one of the files mentioned below."
	echo
	einfo "Helpful note from an's author:"
	einfo "   If you do not have a dictionary you can obtain one from the"
	einfo "   following site: ftp://ftp.funet.fi/pub/doc/dictionaries/"
	einfo "   You will find a selection of dictionaries in many different"
	einfo "   languages here."
}
