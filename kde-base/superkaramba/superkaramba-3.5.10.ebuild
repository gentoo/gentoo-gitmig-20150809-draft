# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/superkaramba/superkaramba-3.5.10.ebuild,v 1.5 2009/06/03 14:44:23 ranger Exp $

KMNAME=kdeutils
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="A tool to create interactive applets for the KDE desktop."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ppc ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

RDEPEND="!x11-misc/superkaramba"

PATCHES=( "${FILESDIR}/${PN}-3.5.2-multilib-python.diff"
	"${FILESDIR}/${PN}-3.5.7-network_sensor.patch"
	"${FILESDIR}/${PN}-python-2.6.patch" )

pkg_setup() {
	if ! built_with_use dev-lang/python threads ; then
		eerror "superkarambe needs dev-lang/python built with threads USE flag."
		eerror "Please enable this USE flag and re-install dev-lang/python."
		die "dev-lang/python needs to be rebuilt with threads support."
	fi

	kde_pkg_setup
}
