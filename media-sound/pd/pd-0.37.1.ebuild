# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pd/pd-0.37.1.ebuild,v 1.1 2004/03/25 02:56:28 eradicator Exp $

inherit eutils

# Miller Puckette uses nonstandard versioning scheme that we have to crunch
MY_P=`echo ${P} | sed 's/\.\([0-9]\+\)$/-\1/'`
S=${WORKDIR}/${MY_P}

DESCRIPTION="real-time music and multimedia environment"
HOMEPAGE="http://www-crca.ucsd.edu/~msp/software.html"
SRC_URI="http://www-crca.ucsd.edu/~msp/Software/${MY_P}.src.tar.gz"

LICENSE="BSD | as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="X alsa"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc2 )
	X? ( x11-base/xfree )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-exp.patch
}

src_compile() {
	cd src
	econf \
		`use_enable alsa` \
		`use_with X x` \
		`use_enable debug` \
		|| die "./configure failed"

	# Fix borkage
	sed -i 's:cp -pr ../doc ../extra $(INSTDIR)/lib/pd/:#:' ${S}/src/makefile

	emake || die "parallel make failed"
}

src_install() {
	cd src
	# -k to bypass the errors about doc missing, etc...
	make DESTDIR=${D} install || die "install failed"
}
