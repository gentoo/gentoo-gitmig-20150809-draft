# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xforms/xforms-1.0-r1.ebuild,v 1.1 2005/03/27 06:07:11 usata Exp $

inherit eutils

S=${WORKDIR}/${P}-release
DESCRIPTION="A graphical user interface toolkit for X"
HOMEPAGE="http://world.std.com/~xforms/"
SRC_URI="ftp://ncmir.ucsd.edu/pub/xforms/OpenSource/${P}-release.tgz
	cjk? ( ftp://cellular.phys.pusan.ac.kr/CJK-LyX/xforms/${P}-i18n_7.patch )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

DEPEND="virtual/x11
	>=sys-apps/sed-4"
IUSE="cjk"

PROVIDE="virtual/xforms"

src_unpack() {
	unpack ${P}-release.tgz
	cd ${WORKDIR}/${P}-release

	use cjk && epatch ${DISTDIR}/${P}-i18n_7.patch

	# use custom CFLAGS
	sed -i -e "s:CDEBUGFLAGS =:CDEBUGFLAGS = ${CFLAGS} #:" \
		-e "s:CDEBUGFLAGS	=:CDEBUGFLAGS	= ${CFLAGS} #:" Imakefile
}

src_compile() {
	xmkmf -a
	sed -i -e s/'demos$'// Makefile

	# use custom CFLAGS
	sed -i -e "s:CDEBUGFLAGS =:CDEBUGFLAGS = ${CFLAGS} #:" \
		-e "s:CDEBUGFLAGS	=:CDEBUGFLAGS	= ${CFLAGS} #:" Makefile

	make || die
}

src_install () {
	make DESTDIR=${D} install || die
}
