# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cscope/cscope-15.4-r1.ebuild,v 1.5 2004/07/14 22:54:57 agriffis Exp $

inherit gnuconfig elisp-common

DESCRIPTION="CScope - interactively examine a C program"
SRC_URI="mirror://sourceforge/cscope/${P}.tar.gz"
HOMEPAGE="http://cscope.sourceforge.net"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 -ppc -sparc -alpha -hppa -mips ppc64"

IUSE="emacs"

RDEPEND=">=sys-libs/ncurses-5.2"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	sys-devel/flex
	sys-devel/bison
	emacs? ( virtual/emacs )"

SITEFILE=50xcscope-gentoo.el

src_compile() {
	gnuconfig_update

	sed -i -e "s:={:{:" src/egrep.y

	econf || die
	make clean || die
	emake || die

	if use emacs
	then
		cd ${S}/contrib/xcscope
		elisp-compile *.el
	fi
}

src_install() {
	einstall || die
	dodoc NEWS AUTHORS TODO COPYING ChangeLog INSTALL README*

	if use emacs
	then
		cd ${S}/contrib/xcscope
		elisp-install xcscope *.el *.elc
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
		dobin cscope-indexer
	fi
	cp -r ${S}/contrib/webcscope ${D}/usr/share/doc/${P}/
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
