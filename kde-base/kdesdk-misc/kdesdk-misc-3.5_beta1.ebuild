# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-misc/kdesdk-misc-3.5_beta1.ebuild,v 1.2 2005/10/14 18:41:53 danarmak Exp $

KMNAME=kdesdk
KMNOMODULE="true"
KMNODOCS="true"
MAXKDEVER=3.5.0_beta2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kdesdk-misc - Various files and utilities"
KEYWORDS="~amd64"
IUSE=""

KMEXTRA="kdepalettes/
	kdeaccounts-plugin/
	scheck/
	poxml/
	kprofilemethod/"