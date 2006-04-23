# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gksu/gksu-1.0.5.ebuild,v 1.9 2006/04/23 02:35:56 dragonheart Exp $

DESCRIPTION="This library provides a gtk+ front end to su and sudo"
HOMEPAGE="http://www.nongnu.org/gksu/"
SRC_URI="http://people.debian.org/~kov/gksu/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE="nls"
RDEPEND="
	>=x11-libs/gtk+-2
	x11-libs/pango
	nls? ( sys-devel/gettext )
	dev-libs/glib
	app-admin/sudo
	|| (
	( >=x11-libs/libX11-1.0.0 )
	virtual/x11 )"

DEPEND="${RDEPEND}
	sys-apps/gawk
	sys-apps/sed
	sys-devel/bison"

src_compile() {

	econf `use_enable nls` || die "Configure failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die
}
