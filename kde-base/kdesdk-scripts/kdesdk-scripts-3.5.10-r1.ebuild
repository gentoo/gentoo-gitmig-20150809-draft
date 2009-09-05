# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-scripts/kdesdk-scripts-3.5.10-r1.ebuild,v 1.3 2009/09/05 22:42:32 maekke Exp $

KMNAME=kdesdk
KMMODULE="scripts"
EAPI="1"
inherit kde-meta

DESCRIPTION="Kdesdk Scripts - Some useful scripts for the development of applications"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

src_unpack() {
	kde-meta_src_unpack

	# bug 275069
	sed -rie 's:color(cvs(rc-sample)?|svn)::g' scripts/Makefile.am || die
}
