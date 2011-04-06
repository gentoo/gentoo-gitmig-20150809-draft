# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rednotebook/rednotebook-1.1.2.ebuild,v 1.2 2011/04/06 20:19:22 arfrever Exp $

EAPI="3"

PYTHON_DEPEND="2"
inherit eutils distutils

DESCRIPTION="A graphical journal with calendar, templates, tags, keyword searching, and export functionality"
HOMEPAGE="http://rednotebook.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libyaml spell webkit"

RDEPEND="dev-python/pyyaml[libyaml?]
	>=dev-python/pygtk-2.13
	spell? ( dev-python/gtkspell-python )
	webkit? ( dev-python/pywebkitgtk )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	! use webkit && epatch "${FILESDIR}/${P}-disable-webkit.patch"
	! use spell && epatch "${FILESDIR}/${PN}-1.1.0-disable-spell.patch"
	distutils_src_prepare
}
