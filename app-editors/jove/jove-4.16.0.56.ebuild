# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jove/jove-4.16.0.56.ebuild,v 1.1 2005/03/25 21:44:02 seemant Exp $

inherit eutils

MY_DIFFV=1
MY_DIFFP=${P/-/_}-${MY_DIFFV}.diff
DESCRIPTION="Jonathan's Own Version of Emacs -- a light emacs-like editor without LISP bindings"
HOMEPAGE="ftp://ftp.cs.toronto.edu/cs/ftp/pub/hugh/jove-dev/"
SRC_URI="mirror://debian/pool/main/j/${PN}/${P/-/_}.orig.tar.gz
	mirror://debian/pool/main/j/${PN}/${MY_DIFFP}.gz"
RESTRICT="nomirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="X"

RDEPEND="sys-libs/ncurses
	X? ( x11-libs/xview )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/${P}.orig

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${MY_DIFFP}

	sed -i \
		-e "s:^OPTFLAGS =.*:OPTFLAGS = ${CFLAGS}:" \
		-e "s:-ltermcap:-lncurses:" \
		Makefile
}

src_compile() {
	emake || die

	if use X ; then
		emake XJOVEHOME=/usr makexjove || die
	fi
}

src_install() {
	emake DESTDIR=${D} install || die

	if use X ; then
		make DESTDIR=${D} XJOVEHOME=${D}/usr MANDIR=${D}/usr/share/man/man1 installxjove || die
	fi

	keepdir /var/lib/jove/preserve
}
