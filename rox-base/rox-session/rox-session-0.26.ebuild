# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox-session/rox-session-0.26.ebuild,v 1.3 2006/01/18 20:36:58 vanquirius Exp $

inherit rox eutils

MY_PN="ROX-Session"
DESCRIPTION="Rox-Session is a really simple session manager"
HOMEPAGE="http://rox.sourceforge.net/rox_session.html"
SRC_URI="mirror://sourceforge/rox/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""

DEPEND="rox-base/rox
		=sys-apps/dbus-0.2*
		>=dev-libs/libxml2-2.0"

APPNAME=${MY_PN}
S="${WORKDIR}/${MY_PN}-${PV}"

src_unpack() {
	if ! built_with_use sys-apps/dbus python
	then
		einfo "Rox-Session requires dbus to be built with python support."
		einfo "Please rebuild dbus with USE=\"python\"."
		die "python dbus modules missing"
	fi
	unpack ${A}
	cd "${S}"
}

pkg_preinst() {
	# need to fixup some permissions
	cd "${D}"/usr/lib/rox/${APPNAME}
	chmod 0755 browser Login ROX-Session RunROX ROX-Session \
		ROX-Session.dbg RunROX SetupPanel *.py *.py?
	# clean up a stray directory used in the build process
	rm -rf build
}

pkg_postinst() {
	echo
	einfo "ROX-Session has been installed into /usr/lib/rox/${APPNAME}."
	einfo "Please review its documentation about proper use. A symlink"
	einfo "for the executable has been created as /usr/bin/${APPNAME}."
	echo
	ewarn "${APPNAME} is incompatible with DBUS versions >=0.30, so"
	ewarn "please stick with DBUS 0.2x for now. This problem is being"
	ewarn "worked on and is being patched in cvs. Updates will be posted"
	ewarn "when fully tested."
}
