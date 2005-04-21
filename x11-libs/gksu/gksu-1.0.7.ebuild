# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gksu/gksu-1.0.7.ebuild,v 1.1 2005/04/21 11:16:30 dragonheart Exp $

DESCRIPTION="This library provides a gtk+ front end to su and sudo"
HOMEPAGE="http://www.nongnu.org/gksu/"
SRC_URI="http://people.debian.org/~kov/gksu/1.0/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="nls"

DEPEND="sys-apps/gawk
	sys-apps/sed
	sys-apps/grep
	>=x11-libs/gtk+-2
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	sys-devel/libtool
	sys-devel/gcc
	virtual/libc
	>=dev-util/gtk-doc-1.0
	sys-devel/m4
	sys-devel/bison"

RDEPEND="dev-libs/atk
	dev-libs/expat
	dev-libs/glib
	media-libs/fontconfig
	media-libs/freetype
	virtual/libc
	sys-libs/zlib
	virtual/x11
	x11-libs/gtk+
	x11-libs/pango
	app-admin/sudo"


src_compile() {

	econf `use_enable nls` || die "Configure failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die
}
