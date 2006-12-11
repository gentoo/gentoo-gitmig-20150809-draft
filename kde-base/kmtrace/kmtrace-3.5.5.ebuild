# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmtrace/kmtrace-3.5.5.ebuild,v 1.10 2006/12/11 11:01:52 kloeri Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kmtrace - A KDE tool to assist with malloc debugging using glibc's \"mtrace\" functionality"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="kdehiddenvisibility"
DEPEND="sys-libs/glibc" # any other libc won't work, says the README file

RDEPEND="${DEPEND}"

