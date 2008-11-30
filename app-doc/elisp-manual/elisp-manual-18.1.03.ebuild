# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/elisp-manual/elisp-manual-18.1.03.ebuild,v 1.1 2008/11/30 21:28:55 ulm Exp $

inherit eutils versionator

MY_PV=$(replace_version_separator 1 '-' )
MY_P=${PN}-${MY_PV}
DESCRIPTION="The GNU Emacs Lisp Reference Manual"
HOMEPAGE="http://www.gnu.org/software/emacs/manual/"
SRC_URI="ftp://ftp.gnu.org/old-gnu/emacs/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="18"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}/elisp"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# remove pre-made info files
	rm -f elisp elisp-[0-9]*
	epatch "${FILESDIR}/${P}-fix-texinfo.patch"
	epatch "${FILESDIR}/${P}-direntry.patch"
}

src_compile() {
	ln -s index.unperm index.texi
	makeinfo elisp.texi || die "makeinfo failed"
}

src_install() {
	doinfo elisp18.info* || die "doinfo failed"
}
