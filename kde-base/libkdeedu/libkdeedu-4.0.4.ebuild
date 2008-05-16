# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdeedu/libkdeedu-4.0.4.ebuild,v 1.1 2008/05/16 00:44:37 ingmar Exp $

EAPI="1"

KMNAME=kdeedu
inherit kde4-meta

# Tests are broken. Last checked in 4.0.3.
RESTRICT="test"

DESCRIPTION="common library for kde educational apps."
KEYWORDS="~amd64 ~x86"
IUSE="debug"
