# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/xtla/xtla-0.9_p38.ebuild,v 1.1 2005/01/26 16:44:52 mkennedy Exp $

inherit elisp

XTLA_VERSION=${PV:0:3}
XTLA_PATCH=${PF:10}
XTLA_REVISION=${PN}--main--${PV:0:3}--patch-${PF:10}

# There are many XTLA archives.	 The archive used here is the current mainline
# from Matthieu MOY, http://www-verimag.imag.fr/~moy/arch/public/.	To compute a
# new snapshot for the source archive, determine the latest revision and "tla
# get" it.	Then make an archive from the directory "tla get" creates, using an
# archive file name based on the directory name.

IUSE=""

DESCRIPTION="XTLA - The Emacs interface to GNU TLA"
HOMEPAGE="http://wiki.gnuarch.org/moin.cgi/xtla
	https://gna.org/projects/xtla-el
	http://www.gnu.org/software/gnu-arch/"
SRC_URI="mirror://gentoo/${PN}--main--${PV:0:3}--patch-${PF:10}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

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
	dodoc COPYING INSTALL docs/*
}
