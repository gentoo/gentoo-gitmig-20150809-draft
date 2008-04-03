# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdeedu/libkdeedu-4.0.3.ebuild,v 1.1 2008/04/03 21:40:44 philantrop Exp $

EAPI="1"

KMNAME=kdeedu
inherit kde4-meta

# Tests are broken. Last checked in 4.0.3.
RESTRICT="test"

DESCRIPTION="common library for kde educational apps."
KEYWORDS="~amd64 ~x86"
IUSE="debug"
