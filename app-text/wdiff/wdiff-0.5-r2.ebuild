# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wdiff/wdiff-0.5-r2.ebuild,v 1.13 2008/05/12 09:13:21 corsair Exp $

inherit eutils

DESCRIPTION="Create a diff disregarding formatting"
HOMEPAGE="http://www.gnu.org/software/wdiff/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 mips ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="build"

DEPEND="sys-apps/diffutils
	sys-apps/less"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-gentoo.diff
	epatch ${FILESDIR}/${P}-segfault-fix.diff
	epatch ${FILESDIR}/${P}-avoid-wraps.diff
	sed -i 's:-ltermcap:-lncurses:' configure
}

src_compile() {
	# Cannot use econf here because the configure script that
	# comes with wdiff is too old to understand the standard
	# options.

	./configure --prefix=/usr || die
	echo '#define HAVE_TPUTS 1' >>config.h
	emake || die
}

src_install() {
	einstall || die

	if ! use build
	then
		dodoc ChangeLog NEWS README
		doman wdiff.1
	else
		rm -rf ${D}/usr/share/info
	fi
}
