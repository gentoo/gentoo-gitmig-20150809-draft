# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cscope/cscope-15.4.ebuild,v 1.7 2003/09/20 06:28:21 seemant Exp $

inherit elisp gnuconfig

S=${WORKDIR}/${P}
DESCRIPTION="CScope - interactively examine a C program"
SRC_URI="mirror://sourceforge/cscope/${P}.tar.gz"
HOMEPAGE="http://cscope.sourceforge.net"

SLOT="0"
LICENSE="as-is"
KEYWORDS="-x86 -ppc -sparc -alpha -hppa -mips -arm"

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
		emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
	fi
}

src_install() {
	einstall || die
	dodoc NEWS AUTHORS TODO COPYING Changelog INSTALL README*

	if use emacs
	then
		cd ${S}/contrib/xcscope
		elisp-install ${PN} *.el *.elc
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
		dobin cscope-indexer
	fi

	cp -r ${S}/contrib/webcscope ${D}/usr/share/doc/${P}/
}
