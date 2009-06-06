# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-misc/kdesdk-misc-3.5.10.ebuild,v 1.4 2009/06/06 10:40:03 maekke Exp $

KMNAME=kdesdk
KMNOMODULE="true"
KMNODOCS="true"
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="kdesdk-misc - Various files and utilities"
KEYWORDS="~alpha amd64 ~hppa ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

KMEXTRA="kdepalettes/
	kdeaccounts-plugin/
	scheck/
	poxml/
	kprofilemethod/"
