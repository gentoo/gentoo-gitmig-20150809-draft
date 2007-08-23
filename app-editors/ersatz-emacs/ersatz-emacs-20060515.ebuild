# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ersatz-emacs/ersatz-emacs-20060515.ebuild,v 1.2 2007/08/23 20:10:53 ulm Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A very minimal imitation of the famous GNU Emacs editor"
HOMEPAGE="http://hunter.apana.org.au/~cjb/Code/"
# taken from http://hunter.apana.org.au/~cjb/Code/ersatz.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"
PROVIDE="virtual/editor"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
	sed -i -e "s%/usr/local/share/%/usr/share/doc/${PF}/%" ee.1 \
		|| die "sed failed"
}

src_compile() {
	emake CC="$(tc-getCC)" \
		CFLAGS="-Wall ${CFLAGS}" \
		LFLAGS="-lncurses" || die "emake failed"
}

src_install() {
	# Note: /usr/bin/ee is "easy edit" on FreeBSD, so if this
	# is ever keyworded *-fbsd the binary has to be renamed.
	dobin ee
	doman ee.1
	dodoc ChangeLog ERSATZ.keys README || die "dodoc failed"
}
