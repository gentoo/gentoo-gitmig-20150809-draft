# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/conque/conque-1.0.ebuild,v 1.1 2010/05/07 19:06:36 spatz Exp $

EAPI=3

VIM_PLUGIN_VIM_VERSION="7.1"
inherit vim-plugin

MY_P="${PN}_${PV}"

DESCRIPTION="vim plugin: Run interactive commands inside a Vim buffer"
HOMEPAGE="http://code.google.com/p/conque/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="ConqueTerm"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	rm "${S}/conque_term.vba"
}
