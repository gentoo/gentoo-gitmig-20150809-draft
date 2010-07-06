# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rednotebook/rednotebook-0.9.0.ebuild,v 1.6 2010/07/06 15:05:55 arfrever Exp $

EAPI="2"

PYTHON_DEPEND="2"
inherit eutils distutils

DESCRIPTION="A graphical journal with calendar, templates, tags, keyword searching, and export functionality"
HOMEPAGE="http://rednotebook.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="libyaml spell"

RDEPEND="dev-python/pyyaml[libyaml?]
	>=dev-python/pygtk-2.13
	spell? ( dev-python/gtkspell-python )"

src_prepare() {
	! use spell && epatch "${FILESDIR}/${PN}-0.8.9_disable_spell.patch"
	distutils_src_prepare
}
