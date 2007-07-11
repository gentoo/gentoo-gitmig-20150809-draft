# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kapptemplate/kapptemplate-3.5.5.ebuild,v 1.11 2007/07/11 01:08:48 mr_bones_ Exp $

ARTS_REQUIRED="no"
RESTRICT="binchecks strip"

KMNAME=kdesdk
MAXKDEVER=3.5.6
KM_DEPRANGE="3.5.0 $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KAppTemplate - A shell script that will create the necessary framework to develop various KDE applications"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
