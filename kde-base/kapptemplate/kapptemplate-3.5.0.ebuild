# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kapptemplate/kapptemplate-3.5.0.ebuild,v 1.13 2006/07/25 03:12:11 flameeyes Exp $

KMNAME=kdesdk
MAXKDEVER=3.5.4
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KAppTemplate - A shell script that will create the necessary framework to develop various KDE applications"
KEYWORDS="alpha amd64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

