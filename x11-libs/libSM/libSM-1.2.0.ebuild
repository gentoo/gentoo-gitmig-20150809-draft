# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libSM/libSM-1.2.0.ebuild,v 1.5 2010/12/25 20:25:04 fauli Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="X.Org SM library"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE="doc ipv6 +uuid"

RDEPEND="x11-libs/libICE
	x11-libs/xtrans
	x11-proto/xproto
	!elibc_FreeBSD? (
		uuid? ( >=sys-apps/util-linux-2.16 )
	)"
DEPEND="${RDEPEND}
	doc? ( app-text/xmlto )"

pkg_setup() {
	xorg-2_pkg_setup

	CONFIGURE_OPTIONS="$(use_enable ipv6)
		$(use_enable doc docs)
		$(use_with doc xmlto)
		$(use_with uuid libuuid)
		--without-fop"
	# do not use uuid even if available in libc (like on FreeBSD)
	use uuid || export ac_cv_func_uuid_create=no
}
