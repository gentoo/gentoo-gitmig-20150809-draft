# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/eprog/eprog-0.0.0.20030629.ebuild,v 1.1 2003/06/29 19:40:33 vapier Exp $

inherit enlightenment

DESCRIPTION="convenience library for evas2"
HOMEPAGE="http://www.rephorm.com/rephorm/code/eprog/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

DEPEND="${DEPEND}
	virtual/x11
	>=x11-libs/evas-1.0.0.2003*
	>=x11-libs/ecore-0.0.2.2003*"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	gettext_modify
}

src_compile() {
	env PATH="${T}:${PATH}" WANT_AUTOCONF_2_5=1 NOCONFIGURE=yes ./autogen.sh || die
	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README
}
