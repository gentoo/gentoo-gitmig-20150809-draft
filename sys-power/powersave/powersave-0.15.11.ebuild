# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/powersave/powersave-0.15.11.ebuild,v 1.8 2008/09/03 07:17:06 opfer Exp $

inherit eutils libtool kde-functions autotools

DESCRIPTION="Powersave Daemon"
SRC_URI="mirror://sourceforge/powersave/${P}.tar.bz2"
HOMEPAGE="http://powersave.sf.net/"
KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="doc"

RDEPEND="dev-libs/dbus-glib
	>=sys-apps/hal-0.5.3
	>=sys-power/cpufrequtils-001
	dev-libs/liblazy"
DEPEND="${RDEPEND}
	doc? (
		app-doc/doxygen
		virtual/latex-base
		www-client/lynx
	)
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/powersave-as-needed.patch"
	# Use group plugdev to control access to powersave
	epatch "${FILESDIR}/plugdev_access.patch"
}

src_compile() {
	set-kdedir

	econf \
		--with-gnome-bindir=/usr/bin \
		--with-kde-bindir=${KDEDIR}/bin \
		$(use_enable doc docs) || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	rm "${D}"/usr/sbin/rcpowersaved
	rm -rf "${D}"/usr/share/doc/packages

	dodoc docs/powersave.html docs/powersave_manual.txt

	newinitd "${FILESDIR}"/powersaved.rc powersaved
}
