# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/xtla/xtla-0.1_p525.ebuild,v 1.1 2004/10/19 20:37:25 mkennedy Exp $

inherit elisp

XTLA_VERSION=${PV:0:3}
XTLA_PATCH=${PF:10}
XTLA_REVISION=${PN}--main--${PV:0:3}--patch-${PF:10}

IUSE=""

DESCRIPTION="XTLA - The Emacs interface to GNU TLA"
HOMEPAGE="http://wiki.gnuarch.org/moin.cgi/xtla
	https://gna.org/projects/xtla-el
	http://www.gnu.org/software/gnu-arch/"
SRC_URI="mirror://gentoo/${PN}--main--${PV:0:3}--patch-${PF:10}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/emacs
	sys-devel/autoconf
	sys-devel/automake"

RDEPEND="virtual/emacs
	dev-util/tla"

S=${WORKDIR}/${XTLA_REVISION}

SITEFILE=50xtla-gentoo.el

src_compile() {
	autoreconf && ./configure --prefix=/usr
	make || die
}

src_install() {
	elisp-install ${PN} lisp/*.{el,elc}
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	doinfo texinfo/xtla.info
	dodoc INSTALL docs/*
}
