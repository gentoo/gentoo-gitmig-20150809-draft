# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pd/pd-0.35.0-r1.ebuild,v 1.1 2002/09/25 19:19:55 raker Exp $

# Miller Puckette uses nonstandard versioning scheme that we have to crunch
MY_P=`echo ${P} | sed 's/\.\([0-9]\+\)$/-\1/'`
S=${WORKDIR}/${MY_P}

DESCRIPTION="real-time music and multimedia environment"
SRC_URI="http://www-crca.ucsd.edu/~msp/Software/${MY_P}.linux.tar.gz"
HOMEPAGE="http://www-crca.ucsd.edu/~msp/software.html"

SLOT="0"
LICENSE="BSD | as-is"
KEYWORDS="x86"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc2 )
	X? ( x11-base/xfree )"
RDEPEND="${DEPEND}"

src_unpack() {

	unpack ${A}

	cd ${S} || die
	patch -p1 < ${FILESDIR}/0.35.0-r1.patch || die

	cd src || die
	autoconf || die

}

src_compile() {

	cd src

	local myconf
	
	use alsa && myconf="--enable-alsa" \
		|| myconf="--disable-alsa"

	use X && myconf="${myconf} --with-x" \
		|| myconf="${myconf} --without-x"

	if [ -n "$DEBUG" ]; then
		myconf="${myconf} --enable-debug"
	else
		myconf="${myconf} --disable-debug"
	fi

	econf ${myconf} || die "./configure failed"

	emake || die "parallel make failed"

}

src_install () {

	cd src
	make \
		DESTDIR=${D} \
		install || die "install failed"

}
