# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pd/pd-0.37.1.ebuild,v 1.6 2004/04/08 07:22:23 eradicator Exp $

inherit eutils

# Miller Puckette uses nonstandard versioning scheme that we have to crunch
MY_P=`echo ${P} | sed 's/\.\([0-9]\+\)$/-\1/'`
S=${WORKDIR}/${MY_P}/src

DESCRIPTION="real-time music and multimedia environment"
HOMEPAGE="http://www-crca.ucsd.edu/~msp/software.html"
SRC_URI="http://www-crca.ucsd.edu/~msp/Software/${MY_P}.src.tar.gz"

LICENSE="BSD | as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="X alsa"

RDEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc2 )
	X? ( virtual/x11 )"

DEPEND="${RDEPEND}
	sys-apps/sed"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-exp.patch

	# Fix install borkage... this errors in sandbox, but it still performs the copy,
	# so we remove it from the makefile and just do it ourselves ignoring the error
	sed -i 's:\(cp -pr ../doc ../extra $(INSTDIR)/lib/pd/\):# \1:' ${S}/makefile.in
}

src_compile() {
	econf \
		`use_enable alsa` \
		`use_with X x` \
		`use_enable debug` \
		|| die "./configure failed"

	emake || die "parallel make failed"
}

src_install() {
	# -k to bypass the errors about doc missing, etc...
	make DESTDIR=${D} install || die "install failed"

	cd ..
	cp -pr doc extra ${D}/usr/lib/pd
}
