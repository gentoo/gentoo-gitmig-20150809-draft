# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rednotebook/rednotebook-0.9.5.ebuild,v 1.2 2010/07/06 21:02:25 hwoarang Exp $

EAPI="2"

PYTHON_DEPEND="2"
inherit python eutils distutils

DESCRIPTION="A graphical journal with calendar, templates, tags, keyword searching, and export functionality"
HOMEPAGE="http://rednotebook.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="libyaml spell webkit"

RDEPEND="dev-python/pyyaml[libyaml?]
	>=dev-python/pygtk-2.13
	spell? ( dev-python/gtkspell-python )
	webkit? ( dev-python/pywebkitgtk )"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	! use webkit && epatch "${FILESDIR}/${PN}-0.9.3-disable-webkit.patch"
	! use spell && epatch "${FILESDIR}/${PN}-0.8.9_disable_spell.patch"
	distutils_src_prepare
}
