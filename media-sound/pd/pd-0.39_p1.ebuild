# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pd/pd-0.39_p1.ebuild,v 1.4 2006/09/03 22:03:29 tsunam Exp $

IUSE="alsa debug jack"

inherit eutils

# Miller Puckette uses nonstandard versioning scheme that we have to crunch
MY_P="${P/_p/-}"
S=${WORKDIR}/${MY_P}/src

DESCRIPTION="real-time music and multimedia environment"
HOMEPAGE="http://www-crca.ucsd.edu/~msp/software.html"
SRC_URI="http://www-crca.ucsd.edu/~msp/Software/${MY_P}.src.tar.gz"

LICENSE="|| ( BSD as-is )"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc2 )
	jack? ( >=media-sound/jack-audio-connection-kit-0.99.0-r1 )"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}/${MY_P}/extra"
	for dir in bonk~ choice expr~ fiddle~ loop~ lrshift~ pique ; do
		sed -i -e "/strip.*/d" ${dir}/makefile || die "sed failed for removing
		prestrip files from extra/${dir}/makefile"
	done
}

src_compile() {
	local myconf

	# --enable-alsa is bork
	if ! use alsa; then
		myconf="${myconf} --disable-alsa"
	fi

	econf \
		${myconf} \
		$(use_enable jack) \
		$(use_enable debug) \
		|| die "./configure failed"
	emake || die "parallel make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	# tb: install private headers ... several external developers use them
	insinto /usr/include
	doins m_imp.h g_canvas.h
}
