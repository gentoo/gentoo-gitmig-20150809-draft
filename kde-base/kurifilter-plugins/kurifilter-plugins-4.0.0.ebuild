# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kurifilter-plugins/kurifilter-plugins-4.0.0.ebuild,v 1.1 2008/01/18 01:13:56 ingmar Exp $

EAPI="1"

KMNAME=kdebase-runtime
inherit kde4-meta

DESCRIPTION="KDE: Plugins to manage filtering URIs."
KEYWORDS="~amd64 ~x86"
IUSE="debug"
# Tests segfault.
RESTRICT="test"
