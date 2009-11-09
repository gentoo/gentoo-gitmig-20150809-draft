# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rednotebook/rednotebook-0.8.9.ebuild,v 1.1 2009/11/09 20:01:22 hwoarang Exp $

EAPI="2"

NEED_PYTHON="2.6"
inherit distutils

DESCRIPTION="A graphical journal with calendar, templates, tags, keyword searching, and export functionality"
HOMEPAGE="http://digitaldump.wordpress.com/projects/rednotebook/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libyaml"

RDEPEND="dev-python/pyyaml[libyaml?]
	>=dev-python/pygtk-2.13"
