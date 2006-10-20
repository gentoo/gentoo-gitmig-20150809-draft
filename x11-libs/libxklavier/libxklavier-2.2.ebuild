# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxklavier/libxklavier-2.2.ebuild,v 1.13 2006/10/20 15:52:30 agriffis Exp $

inherit eutils

DESCRIPTION="High level XKB library"
HOMEPAGE="http://www.freedesktop.org/Software/LibXklavier"
SRC_URI="mirror://sourceforge/gswitchit/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ppc64 s390 sh sparc x86"
IUSE="doc"

RDEPEND="|| ( (
		|| ( x11-misc/xkeyboard-config x11-misc/xkbdata )
		x11-apps/xkbcomp
		x11-libs/libX11
		x11-libs/libxkbfile )
	virtual/x11 )
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Do not error on warnings (for gcc4 support).  Patch from Fedora.
	epatch "${FILESDIR}"/${PN}-1.14-werror.patch
}

src_compile() {
	local xkbbase

	# see bug #113108
	if has_version x11-apps/xkbcomp ; then
		xkbbase=/usr/share/X11/xkb
	else
		xkbbase=/usr/$(get_libdir)/X11/xkb
	fi

	econf \
		--with-xkb-base=${xkbbase} \
		--with-xkb-bin-base=/usr/bin \
		$(use_enable doc doxygen) || die

	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die
	insinto /usr/share/libxklavier
	use sparc && doins "${FILESDIR}/sun.xml"
	dodoc AUTHORS CREDITS ChangeLog NEWS README
}
