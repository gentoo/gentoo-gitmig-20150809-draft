# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/kportagetray/kportagetray-0.1.ebuild,v 1.2 2010/03/10 23:33:47 abcd Exp $

EAPI="2"

KDE_LINGUAS="pt_BR"
PYTHON_DEPEND="2:2.6"

inherit kde4-base python

DESCRIPTION="Graphical application for Portage's daily tasks"
HOMEPAGE="https://sourceforge.net/projects/kportagetray/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE=""

DEPEND="
	dev-python/PyQt4[svg,dbus]
	>=kde-base/pykde4-${KDE_MINIMAL}
"
RDEPEND="${DEPEND}
	app-portage/eix
	app-portage/genlop
	>=kde-base/kdesu-${KDE_MINIMAL}
	>=kde-base/knotify-${KDE_MINIMAL}
	>=kde-base/konsole-${KDE_MINIMAL}
"
