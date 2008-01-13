# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/telepathy-inspector/telepathy-inspector-0.5.0.ebuild,v 1.3 2008/01/13 14:59:09 coldwind Exp $

inherit eutils flag-o-matic

DESCRIPTION="The swiss-army knife of every Telepathy developer."
HOMEPAGE="http://telepathy.freedesktop.org/wiki/TelepathyInspector"
SRC_URI="mirror://sourceforge/tapioca-voip/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	gnome-base/libglade
	dev-libs/dbus-glib"
DEPEND="${RDEPEND}
	dev-util/scons
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-scons.patch"
}

src_compile() {
	replace-flags -O? -O1

	local myopts
	if use debug ; then
		myopts="DEBUG=yes"
	else
		myopts="DEBUG=no"
	fi
	scons CONFIGURE=yes DESTDIR="${D}" PREFIX=/usr \
		${myopts} || die "scons failed"
}

src_install() {
	scons install || die "scons install failed"
	dodoc README ChangeLog || die "dodoc failed"
}
