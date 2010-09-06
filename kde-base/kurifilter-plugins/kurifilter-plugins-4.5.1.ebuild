# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kurifilter-plugins/kurifilter-plugins-4.5.1.ebuild,v 1.1 2010/09/06 01:31:53 tampakrap Exp $

EAPI="3"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="KDE: Plugins to manage filtering URIs."
KEYWORDS=""
IUSE="debug"
RESTRICT="test" # Tests segfault. Last checked on 4.0.3.
