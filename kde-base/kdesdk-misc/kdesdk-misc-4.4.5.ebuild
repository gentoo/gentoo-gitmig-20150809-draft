# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-misc/kdesdk-misc-4.4.5.ebuild,v 1.4 2010/08/09 07:27:46 fauli Exp $

EAPI="3"

KMNAME="${PN/-*/}"
KMNOMODULE="true"

inherit kde4-meta

DESCRIPTION="KDE miscellaneous SDK tools"
KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

KMEXTRA="
	kmtrace/
	kpartloader/
	kprofilemethod/
	kspy/
	kunittest/
	poxml/
	scheck/
"
