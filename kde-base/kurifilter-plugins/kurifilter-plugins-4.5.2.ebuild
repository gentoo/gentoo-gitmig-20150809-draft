# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kurifilter-plugins/kurifilter-plugins-4.5.2.ebuild,v 1.1 2010/10/06 09:17:36 alexxy Exp $

EAPI="3"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="KDE: Plugins to manage filtering URIs."
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"
RESTRICT="test" # Tests segfault. Last checked on 4.0.3.
