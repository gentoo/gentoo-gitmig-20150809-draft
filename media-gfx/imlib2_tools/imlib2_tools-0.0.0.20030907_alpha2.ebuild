# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imlib2_tools/imlib2_tools-0.0.0.20030907_alpha2.ebuild,v 1.1 2003/09/18 20:04:05 vapier Exp $

inherit enlightenment

DESCRIPTION="command line programs to utilize Imlib2"
HOMEPAGE="http://www.enlightenment.org/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"

DEPEND="${DEPEND}
	>=media-libs/imlib2-1.1.0"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-imlib-config.patch
}

src_compile() {
#	sed -i 's:--libs --cflags:--cflags:' configure.ac

	sed -i 's:.*configure.*::' autogen.sh
	env USER=BLAH WANT_AUTOCONF_2_5=1 ./autogen.sh || die "could not autogen"

	econf || die "could not econf"
	emake || die "could not emake"
}

src_install() {
	make install DESTDIR=${D} || die "could not install"
	find ${D} -name CVS -type d -exec rm -rf '{}' \;
	dodoc AUTHORS ChangeLog NEWS README TODO
}
