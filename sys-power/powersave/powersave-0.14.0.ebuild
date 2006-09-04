# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/powersave/powersave-0.14.0.ebuild,v 1.1 2006/09/04 13:06:23 genstef Exp $

inherit eutils libtool kde-functions autotools

DESCRIPTION="Powersave Daemon"
SRC_URI="mirror://sourceforge/powersave/${P}.tar.bz2"
HOMEPAGE="http://powersave.sf.net/"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE="pam_console doc"


RDEPEND=">=sys-apps/dbus-0.30
	>=sys-apps/hal-0.5.3
	>=sys-power/cpufrequtils-001
	pam_console? ( sys-libs/pam )"
DEPEND="${RDEPEND}
	doc? (
		app-doc/doxygen
		virtual/tetex
		www-client/lynx
	)"

pkg_setup() {
	if use pam_console && ! built_with_use sys-libs/pam pam_console ; then
		eerror "You need to build pam with pam_console support"
		eerror "Please remerge sys-libs/pam with USE=pam_console"
		die "pam without pam_console detected"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	# Use pam_console or group plugdev to control access to powersave
	use pam_console || epatch ${FILESDIR}/plugdev_access.patch
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
	emake DESTDIR=${D} install || die "emake install failed"

	rm ${D}/usr/sbin/rcpowersaved
	rm -rf ${D}/usr/share/doc/packages

	dodoc docs/powersave.html docs/powersave_manual.txt

	newinitd ${FILESDIR}/powersaved.rc powersaved
}
