# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ebg/ebg-1.0.0.20031013.ebuild,v 1.1 2003/10/14 01:16:16 vapier Exp $

inherit enlightenment

DESCRIPTION="Enlightenment Background Library API: create backgrounds with multiple images, boxes, or gradients"
HOMEPAGE="http://www.enlightenment.org/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~arm ~sparc ~mips ~hppa"

DEPEND="${DEPEND}
	>=x11-libs/evas-1.0.0.20031013_pre12
	>=x11-libs/ecore-1.0.0.20031013_pre4
	>=dev-db/edb-1.0.4.20031013
	>=media-libs/imlib2-1.1.0"

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
	find ${D} -name CVS -type d -exec rm -rf '{}' \;
	dodoc AUTHORS ChangeLog NEWS README
	dohtml -r doc
}
