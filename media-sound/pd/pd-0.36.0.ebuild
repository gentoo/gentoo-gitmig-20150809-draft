# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pd/pd-0.36.0.ebuild,v 1.3 2004/04/03 23:50:06 spyderous Exp $

# Miller Puckette uses nonstandard versioning scheme that we have to crunch
MY_P=`echo ${P} | sed 's/\.\([0-9]\+\)$/-\1/'`
S=${WORKDIR}/${MY_P}

DESCRIPTION="real-time music and multimedia environment"
HOMEPAGE="http://www-crca.ucsd.edu/~msp/software.html"
SRC_URI="http://www-crca.ucsd.edu/~msp/Software/${MY_P}.linux.tar.gz"

LICENSE="BSD | as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="X alsa"

DEPEND="=dev-lang/tcl-8.3*
	=dev-lang/tk-8.3*
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc2 )
	X? ( virtual/x11 )"

src_unpack() {
	unpack ${A}

#	cd ${S} || die
#	epatch ${FILESDIR}/${PF}.patch

#	cd src || die
#	autoconf || die
}

src_compile() {
	cd src
	econf \
		`use_enable alsa` \
		`use_with X x` \
		`use_enable debug` \
		|| die "./configure failed"
	emake || die "parallel make failed"
}

src_install() {
	cd src
	make DESTDIR=${D} install || die "install failed"
}
