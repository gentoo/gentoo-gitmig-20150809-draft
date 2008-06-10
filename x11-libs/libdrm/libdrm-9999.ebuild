# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libdrm/libdrm-9999.ebuild,v 1.1 2008/06/10 07:17:31 dberkholz Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit autotools x-modular git

EGIT_REPO_URI="git://anongit.freedesktop.org/git/mesa/drm"
EGIT_BOOTSTRAP="eautoreconf"

DESCRIPTION="X.Org libdrm library"
HOMEPAGE="http://dri.freedesktop.org/"
SRC_URI=""

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

RDEPEND=""
DEPEND="${RDEPEND}"

pkg_preinst() {
	x-modular_pkg_preinst

	if [[ -e ${ROOT}/usr/$(get_libdir)/libdrm.so.1 ]] ; then
		cp -pPR "${ROOT}"/usr/$(get_libdir)/libdrm.so.{1,1.0.0} "${D}"/usr/$(get_libdir)/
	fi
}

pkg_postinst() {
	x-modular_pkg_postinst

	if [[ -e ${ROOT}/usr/$(get_libdir)/libdrm.so.1 ]] ; then
		elog "You must re-compile all packages that are linked against"
		elog "libdrm 1 by using revdep-rebuild from gentoolkit:"
		elog "# revdep-rebuild --library libdrm.so.1"
		elog "After this, you can delete /usr/$(get_libdir)/libdrm.so.1"
		elog "and /usr/$(get_libdir)/libdrm.so.1.0.0 ."
		epause
	fi
}
