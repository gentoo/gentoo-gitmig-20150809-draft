# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/etcher/etcher-1.0.20030629.ebuild,v 1.1 2003/06/29 20:00:52 vapier Exp $

inherit enlightenment

DESCRIPTION="graphical editing tool for creating and manipulating Ebits GUI elements"
HOMEPAGE="http://www.enlightenment.org/pages/etcher.html"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"

DEPEND="${DEPEND}
	=x11-libs/gtk+-1*
	>=media-libs/imlib2-1.0.6.2003*
	>=x11-libs/evas-1.0.0.2003*
	>=dev-db/edb-1.0.3.2003*"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	gettext_modify
}

src_compile() {
	env PATH="${T}:${PATH}" WANT_AUTOCONF_2_5=1 NOCONFIGURE=yes ./autogen.sh || die
	econf `use_enable nls` --with-gnu-ld || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	find ${D} -name CVS -type d -exec rm -rf '{}' \;
	dodoc AUTHORS ChangeLog NEWS README
}
