# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/entice/entice-0.7.0.20030629.ebuild,v 1.1 2003/06/29 19:52:07 vapier Exp $

inherit enlightenment

DESCRIPTION="the E image browser"
HOMEPAGE="http://www.enlightenment.org/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"

DEPEND="${DEPEND}
	>=media-libs/imlib2-1.0.6.2003*
	>=x11-libs/evas-1.0.0.2003*
	>=dev-db/edb-1.0.3.2003*
	>=x11-libs/ecore-0.0.2.2003*"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	gettext_modify
}

src_compile() {
	env PATH="${T}:${PATH}" WANT_AUTOCONF_2_5=1 NOCONFIGURE=yes ./autogen.sh || die
	econf --with-gnu-ld || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	find ${D} -name CVS -type d -exec rm -rf '{}' \;
	dodoc AUTHORS ChangeLog NEWS README
}
