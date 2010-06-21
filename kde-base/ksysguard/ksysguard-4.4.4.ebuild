# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksysguard/ksysguard-4.4.4.ebuild,v 1.2 2010/06/21 15:52:56 scarabeus Exp $

EAPI="3"

KMNAME="kdebase-workspace"
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KSysguard is a network enabled task manager and system monitor application."
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook lm_sensors"

COMMONDEPEND="
	x11-libs/libXrender
	x11-libs/libXres
	lm_sensors? ( sys-apps/lm_sensors )
"
DEPEND="${COMMONDEPEND}
	x11-proto/renderproto
"
RDEPEND="${COMMONDEPEND}"

KMEXTRA="
	libs/ksysguard/
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with lm_sensors Sensors)
	)

	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-meta_pkg_postinst
	ewarn "Note that ksysguard has powerful features; one of these is the executing of arbitrary"
	ewarn "programs with elevated privileges (as data sources). So be careful opening worksheets"
	ewarn "from untrusted sources!"
}
