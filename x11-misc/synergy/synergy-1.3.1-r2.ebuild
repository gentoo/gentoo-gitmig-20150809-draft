# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/synergy/synergy-1.3.1-r2.ebuild,v 1.2 2010/07/19 18:49:43 darkside Exp $

EAPI=3
inherit eutils autotools

DESCRIPTION="Lets you easily share a single mouse and keyboard between multiple computers."
SRC_URI="mirror://sourceforge/${PN}2/${P}.tar.gz"
HOMEPAGE="http://synergy2.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris ~x86-solaris"
SLOT="0"
IUSE=""

RDEPEND="x11-libs/libXtst
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXinerama"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xproto
	x11-proto/kbproto
	x11-proto/xineramaproto
	x11-libs/libXt"

src_prepare() {
	epatch "${FILESDIR}/${P}+gcc-4.3.patch"

	# fix for #257794
	epatch "${FILESDIR}/${P}-stuttered-delay-fix.patch"

	# fix for #291713
	epatch "${FILESDIR}/${P}-infinite-timeout-fix.patch"

	# Remove -Werror usage.
	sed -i -e '/ACX_CXX_WARNINGS_ARE_ERRORS/d' \
		configure.in || die "unable to sed out -Werror usage."
	eautoreconf
}

src_configure() {
	# debug causes an assertion error in switchInDirection()
	econf --sysconfdir="${EPREFIX}"/etc \
		--disable-dependency-tracking \
		--disable-debug
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
	insinto /etc
	doins "${S}"/examples/synergy.conf
}

pkg_postinst() {
	elog
	elog "${PN} can also be used to connect to computers running Windows."
	elog "Visit ${HOMEPAGE} to find the Windows client."
	elog
}
