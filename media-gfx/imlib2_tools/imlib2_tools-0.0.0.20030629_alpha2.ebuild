# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imlib2_tools/imlib2_tools-0.0.0.20030629_alpha2.ebuild,v 1.1 2003/06/29 19:22:37 vapier Exp $

inherit enlightenment

DESCRIPTION="command line programs to utilize Imlib2"
HOMEPAGE="http://www.enlightenment.org/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"

DEPEND="${DEPEND}
	>=media-libs/imlib2-1.0.6.2003*"

S=${WORKDIR}/${PN}

src_compile() {
	cp autogen.sh{,.old}
	sed -e 's:.*configure.*::' autogen.sh.old > autogen.sh
	env USER=BLAH WANT_AUTOCONF_2_5=1 ./autogen.sh || die "could not autogen"

	econf || die "could not econf"
	emake || die "could not emake"
}

src_install() {
	make install DESTDIR=${D} || die "could not install"
	find ${D} -name CVS -type d -exec rm -rf '{}' \;
	dodoc AUTHORS ChangeLog NEWS README TODO
}
