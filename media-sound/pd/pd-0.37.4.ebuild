# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pd/pd-0.37.4.ebuild,v 1.2 2004/11/23 10:16:35 eradicator Exp $

IUSE="X alsa debug"

inherit eutils versionator

# Miller Puckette uses nonstandard versioning scheme that we have to crunch
MY_PV=$(replace_version_separator 2 '-')
MY_P="${PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}/src

DESCRIPTION="real-time music and multimedia environment"
HOMEPAGE="http://www-crca.ucsd.edu/~msp/software.html"
SRC_URI="http://www-crca.ucsd.edu/~msp/Software/${MY_P}.src.tar.gz"

LICENSE="|| ( BSD as-is )"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"

RDEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc2 )
	X? ( virtual/x11 )"

DEPEND="${RDEPEND}
	sys-apps/sed"

src_unpack() {
	unpack ${A}

	# Fix install borkage... this errors in sandbox, but it still performs the copy,
	# so we remove it from the makefile and just do it ourselves ignoring the error
	sed -i 's:\(cp -pr ../doc ../extra $(INSTDIR)/lib/pd/\):# \1:' ${S}/makefile.in
}

src_compile() {
	local myconf

	# --enable-alsa is bork
	if ! use alsa; then
		myconf="${myconf} --disable-alsa"
	fi

	econf \
		${myconf} \
		`use_with X x` \
		`use_enable debug` \
		|| die "./configure failed"

	emake || die "parallel make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"

	cd ..
	cp -pr doc extra ${D}/usr/lib/pd
}
