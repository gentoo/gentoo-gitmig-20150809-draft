# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lineak-kdeplugins/lineak-kdeplugins-0.9.0.ebuild,v 1.2 2007/06/04 16:12:02 drac Exp $

inherit kde multilib

MY_P=${P/.0/}

DESCRIPTION="KDE plugins for LINEAK"
HOMEPAGE="http://lineak.sourceforge.net/"
SRC_URI="mirror://sourceforge/lineak/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

RDEPEND="=x11-misc/lineakd-${PV}*"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}

need-kde 3.2

src_compile() {
	local myconf="$(use_enable debug)"
	kde_src_compile
}

src_install() {
	emake DESTDIR="${D}" \
		PLUGINDIR=/usr/$(get_libdir)/lineakd/plugins \
		install || die "emake install failed."
	dodoc AUTHORS README
}
