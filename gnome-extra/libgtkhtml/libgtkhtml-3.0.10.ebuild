# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgtkhtml/libgtkhtml-3.0.10.ebuild,v 1.1 2004/03/22 10:13:38 liquidx Exp $

inherit gnome2

MY_P=${P/lib/}
MY_PN=${PN/lib/}
DESCRIPTION="Lightweight HTML Rendering/Printing/Editing Engine"
HOMEPAGE="http://www.gnome.org/"

# stolen from gnome.org eclass because it support this one-off name-mangling

[ -z "${GNOME_TARBALL_SUFFIX}" ] && export GNOME_TARBALL_SUFFIX="bz2"
PVP=($(echo " $PV " | sed 's:[-\._]: :g'))
SRC_URI="mirror://gnome/sources/${MY_PN}/${PVP[0]}.${PVP[1]}/${MY_P}.tar.${GNOME_TARBALL_SUFFIX}"
LICENSE="GPL-2"
SLOT="3"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~alpha ~ia64 ~amd64"
IUSE=""

S=${WORKDIR}/${MY_P}

RDEPEND=">=gnome-extra/gal-1.99.10
	>=net-libs/libsoup-1.99.26
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2.1
	>=gnome-base/libbonoboui-2.0
	>=gnome-base/libbonobo-2.0
	>=gnome-base/ORBit2-2.5.6
	>=gnome-base/gnome-vfs-2.1
	>=gnome-base/gail-1.1
	>=dev-libs/libxml2-2.5"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

USE_DESTDIR="1"
SCROLLKEEPER_UPDATE="0"
ELTCONF="--reverse-deps"

src_compile() {
	gnome2_src_configure

	EPATCH_OPTS="${S}/libtool"
	epatch ${FILESDIR}/${PN}-3.0.7-libtool.patch

	emake || die "make failed"
}
