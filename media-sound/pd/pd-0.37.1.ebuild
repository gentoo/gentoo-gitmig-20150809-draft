# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pd/pd-0.37.1.ebuild,v 1.12 2005/04/12 22:03:09 luckyduck Exp $

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
KEYWORDS="x86 ~ppc"
IUSE="X alsa debug"

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
	# -k to bypass the errors about doc missing, etc...
	make DESTDIR=${D} install || die "install failed"

	cd ..
	cp -pr doc extra ${D}/usr/lib/pd
}
