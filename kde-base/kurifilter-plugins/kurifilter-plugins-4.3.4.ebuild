# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kurifilter-plugins/kurifilter-plugins-4.3.4.ebuild,v 1.3 2010/01/23 17:29:12 armin76 Exp $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="KDE: Plugins to manage filtering URIs."
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"
RESTRICT="test" # Tests segfault. Last checked on 4.0.3.
