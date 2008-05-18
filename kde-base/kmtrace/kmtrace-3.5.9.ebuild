# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmtrace/kmtrace-3.5.9.ebuild,v 1.4 2008/05/18 18:37:51 maekke Exp $

KMNAME=kdesdk
EAPI="1"
inherit kde-meta

DESCRIPTION="kmtrace - A KDE tool to assist with malloc debugging using glibc's \"mtrace\" functionality"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ppc64 ~sparc x86"
IUSE="kdehiddenvisibility"

DEPEND="sys-libs/glibc" # any other libc won't work, says the README file
RDEPEND="${DEPEND}"
