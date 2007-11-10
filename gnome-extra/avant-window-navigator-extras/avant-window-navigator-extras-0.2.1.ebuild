# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/avant-window-navigator-extras/avant-window-navigator-extras-0.2.1.ebuild,v 1.1 2007/11/10 03:13:17 wltjr Exp $

inherit gnome2

MY_P="awn-extras-applets-${PV}"
DESCRIPTION="Applets for the avant-window-navigator"
HOMEPAGE="http://launchpad.net/awn-extras"
SRC_URI="http://launchpad.net/awn-extras/${PV}/${PV}/+download/awn-extras-applets-${PV}.tar"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="gnome-extra/avant-window-navigator"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
