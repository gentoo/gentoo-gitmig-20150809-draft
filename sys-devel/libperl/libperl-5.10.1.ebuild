# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libperl/libperl-5.10.1.ebuild,v 1.5 2009/10/21 19:42:01 maekke Exp $

inherit multilib

DESCRIPTION="Larry Wall's Practical Extraction and Report Language"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~amd64 ~arm ~hppa ~x86"
IUSE=""

PDEPEND=">=dev-lang/perl-5.10.1"

pkg_postinst() {
	if [[ $(readlink "${ROOT}/usr/$(get_libdir )/libperl$(get_libname)" ) == libperl$(get_libname).1 ]] ; then
		einfo "Removing stale symbolic link: ${ROOT}usr/$(get_libdir)/libperl$(get_libname)"
		rm "${ROOT}"/usr/$(get_libdir )/libperl$(get_libname)
	fi
}
