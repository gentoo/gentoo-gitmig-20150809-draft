# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/elisp-manual/elisp-manual-21.2.8-r2.ebuild,v 1.1 2008/11/30 21:28:55 ulm Exp $

inherit eutils versionator

MY_PV=$(replace_version_separator 1 '-' )
MY_P=${PN}-${MY_PV}
DESCRIPTION="The GNU Emacs Lisp Reference Manual"
HOMEPAGE="http://www.gnu.org/software/emacs/manual/"
SRC_URI="mirror://gnu/emacs/${MY_P}.tar.gz"

LICENSE="FDL-1.1"
SLOT="21"
KEYWORDS="~amd64 ~ppc ~s390 ~sparc ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

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
	doinfo elisp21.info* || die "doinfo failed"
}
