# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gksu/gksu-1.2.4.ebuild,v 1.1 2005/05/01 05:03:01 dragonheart Exp $

DESCRIPTION="A gtk+ frontend for libgksu"
HOMEPAGE="http://www.nongnu.org/gksu/"
SRC_URI="http://people.debian.org/~kov/gksu/gksu1.2/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

RDEPEND=">=x11-libs/libgksu-1.2
	>=x11-libs/libgksuui-1.0
	>=dev-libs/atk-1.7.2
	>=x11-libs/gtk+-2.0.0
	app-admin/sudo
	virtual/x11
	nls? ( sys-devel/gettext )"

DEPEND="${RDEPEND}
	sys-apps/gawk
	sys-apps/sed
	sys-devel/bison
	sys-apps/grep"


src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
