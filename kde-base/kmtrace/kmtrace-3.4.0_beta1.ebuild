# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmtrace/kmtrace-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:35 danarmak Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kmtrace - A KDE tool to assist with malloc debugging using glibc's \"mtrace\" functionality"
KEYWORDS="~x86"
IUSE=""
DEPEND="sys-libs/glibc" # any other libc won't work, says the README file

PATCHES="$FILESDIR/liberty-link.diff"