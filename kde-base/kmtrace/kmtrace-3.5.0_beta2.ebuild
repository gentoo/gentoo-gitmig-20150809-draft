# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmtrace/kmtrace-3.5.0_beta2.ebuild,v 1.3 2005/11/12 15:49:30 danarmak Exp $

KMNAME=kdesdk
MAXKDEVER=3.5.0_rc1
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kmtrace - A KDE tool to assist with malloc debugging using glibc's \"mtrace\" functionality"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="sys-libs/glibc" # any other libc won't work, says the README file

