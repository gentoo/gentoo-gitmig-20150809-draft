# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libzeitgeist/libzeitgeist-0.3.4.ebuild,v 1.1 2011/03/02 01:59:07 signals Exp $

EAPI=4
inherit autotools eutils versionator

MY_PV=$(get_version_component_range 1-2)
DESCRIPTION="Client library to interact with zeitgeist"
HOMEPAGE="http://launchpad.net/libzeitgeist"
SRC_URI="http://launchpad.net/libzeitgeist/${MY_PV}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-libs/glib:2"
RDEPEND="gnome-extra/zeitgeist
	${CDEPEND}"
DEPEND="${CDEPEND}"

src_prepare() {
	sed -i -e "s:doc/libzeitgeist:doc/${P}:" \
		Makefile.am || die
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
}
