# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-shares/thunar-shares-0.16.ebuild,v 1.1 2008/12/01 20:43:08 angelos Exp $

EAPI=1

inherit xfce44

DESCRIPTION="Thunar plugin to share files using Samba"
HOMEPAGE="http://code.google.com/p/thunar-shares/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.12:2
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/thunar-0.9"
DEPEND="${RDEPEND}
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README TODO"
