# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cscope/cscope-15.5-r5.ebuild,v 1.1 2006/04/08 21:19:56 mkennedy Exp $

inherit gnuconfig elisp-common eutils

DESCRIPTION="Interactively examine a C program"
HOMEPAGE="http://cscope.sourceforge.net/"
SRC_URI="mirror://sourceforge/cscope/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~x86-fbsd"
IUSE="emacs"

RDEPEND=">=sys-libs/ncurses-5.2"
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison
	emacs? ( virtual/emacs )"

SITEFILE=50xcscope-gentoo.el

src_unpack() {
	unpack ${A}
	cd ${S}

	#rphillips - tempfile security patch
	epatch ${FILESDIR}/${PN}-${PV}-tempfile.patch

	# make it happy with ansi c (from azarah)
	epatch ${FILESDIR}/${PN}-${PV}-gcc295.patch

	# build progress patch	(bug 94150)
	epatch ${FILESDIR}/${PN}-${PV}-prog-info.patch

	# BSD memset test (Bug #129128)
	epatch ${FILESDIR}/${P}-memset.patch
}

src_compile() {
	gnuconfig_update

	# This fix is no longer needed as of cscope-15.5 which now should
	# work with bison directly.	 (04 Feb 2004 agriffis)
	#sed -i -e "s:={:{:" src/egrep.y

	econf || die
	make clean || die
	emake || die

	if use emacs ; then
		cd ${S}/contrib/xcscope || die
		elisp-compile *.el || die
	fi
}

src_install() {
	einstall || die
	dodoc NEWS AUTHORS TODO ChangeLog INSTALL README* || die

	if use emacs ; then
		cd ${S}/contrib/xcscope || die
		elisp-install xcscope *.el *.elc || die
		elisp-site-file-install ${FILESDIR}/${SITEFILE} xcscope || die
		dobin cscope-indexer || die
	fi
	cp -r ${S}/contrib/webcscope ${D}/usr/share/doc/${PF}/ || die
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
