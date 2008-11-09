# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktimetracker/ktimetracker-4.1.3.ebuild,v 1.1 2008/11/09 01:51:10 scarabeus Exp $

EAPI="2"

KMNAME=kdepim
KMMODULE=ktimetracker
inherit kde4-meta

DESCRIPTION="KTimeTracker tracks time spent on various tasks."
IUSE="debug"
KEYWORDS="~amd64 ~x86"

DEPEND="kde-base/kontact:${SLOT}
	kde-base/kdepim-kresources:${SLOT}
	kde-base/libkdepim:${SLOT}"

KMEXTRACTONLY="
	kresources/remote
	libkdepim
"
KMLOADLIBS="libkdepim kontactinterfaces"
