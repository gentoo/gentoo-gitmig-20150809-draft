# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/habak/habak-0.2.5.ebuild,v 1.20 2008/12/27 19:05:04 coldwind Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A simple but powerful tool to set desktop wallpaper"
HOMEPAGE="http://www.fvwm-crystal.org/"
SRC_URI="http://download.gna.org/fvwm-crystal/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="media-libs/imlib2
	x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xproto"

# Skip into the src directory so we avoid a recursive make call that
# is going to break parallel make.
S="${WORKDIR}/${P}/src"

pkg_setup() {
	# fix for bug #185144
	if ! built_with_use media-libs/imlib2 X; then
		eerror "habak needs imlib2 built with X USE flag"
		eerror "Please recompile media-libs/imlib2 with USE=X"
		die "habak needs media-libs/imlib2 built with USE=X"
	fi
}

src_unpack() {
	unpack ${A}

	sed -i \
		-e '/(LDFLAGS)/s:$: -lImlib2 -lm:' \
		-e 's:gcc:$(CC):' \
		"${S}"/Makefile || die "Makefile fixing failed"
}

src_compile() {
	emake CC="$(tc-getCC)" ${PN} || die "make failed"
}

src_install() {
	dobin ${PN} || die "dobin failed"

	cd "${WORKDIR}/${P}"
	dodoc ChangeLog README TODO "${FILESDIR}"/README.en || die "dodoc failed"
}
