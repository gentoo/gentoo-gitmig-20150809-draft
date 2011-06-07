# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/kportagetray/kportagetray-0.2.4.ebuild,v 1.3 2011/06/07 03:05:21 abcd Exp $

EAPI="3"

SCM=""
if [ "${PV%9999}" != "${PV}" ] ; then
	SCM=git
	EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}.git"
fi

KDE_LINGUAS="pt_BR"
PYTHON_DEPEND="2:2.6"

inherit ${SCM} kde4-base python

DESCRIPTION="Graphical application for Portage's daily tasks"
HOMEPAGE="http://gitorious.org/kportagetray"

if [ "${PV%9999}" != "${PV}" ] ; then # Live ebuild
	SRC_URI=""
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
fi

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE=""

DEPEND="
	dev-python/PyQt4[svg,dbus]
	$(add_kdebase_dep pykde4)
"
RDEPEND="${DEPEND}
	app-portage/eix
	app-portage/genlop
	$(add_kdebase_dep kdesu)
	$(add_kdebase_dep knotify)
	$(add_kdebase_dep konsole)
"

pkg_setup() {
	python_set_active_version 2
	kde4-base_pkg_setup
}

src_unpack() {
	if [ "${PV%9999}" != "${PV}" ] ; then
		git_src_unpack
	else
		base_src_unpack
	fi
}

src_prepare() {
	python_convert_shebangs -r 2 .
	kde4-base_src_prepare
}

pkg_postinst() {
	kde4-base_pkg_postinst
}
