# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-weather/xfce4-weather-0.7.3.ebuild,v 1.1 2009/08/04 18:13:25 darkside Exp $

MY_P="${PN}-plugin-${PV}"
inherit xfconf

DESCRIPTION="panel plugin that shows the current temperature and weather condition."
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-weather-plugin"
SRC_URI="http://archive.xfce.org/src/panel-plugins/${PN}-plugin/0.7/${PN}-plugin-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug"

RDEPEND=">=xfce-base/xfce4-panel-4.3.99.1"
DEPEND="${RDEPEND}
	dev-libs/libxml2
	sys-devel/gettext"

EINTLTOOLIZE="yes"
EAUTORECONF="yes"

DOCS="AUTHORS ChangeLog NEWS README TODO"
