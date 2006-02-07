# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/yafray/yafray-0.0.8.ebuild,v 1.7 2006/02/07 21:19:43 blubb Exp $

inherit eutils python multilib

DESCRIPTION="Yet Another Free Raytracer"
HOMEPAGE="http://www.yafray.org/"
SRC_URI="http://www.yafray.org/sec/2/downloads/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND="media-libs/jpeg
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-3.3
	>=sys-apps/sed-4
	dev-util/scons"

export WANT_AUTOMAKE="1.7"

src_unpack() {
	unpack ${A}
	cd ${S}
	libtoolize --copy --force
	epatch ${FILESDIR}/${P}-scons.patch
	epatch ${FILESDIR}/${P}-64bit.patch
	epatch ${FILESDIR}/${P}-libdir.patch
	# Dirty hack for a dirty buildsystem.
	sed -i -e "s:-O3:${CXXFLAGS} -fsigned-char:g" *-settings.py
}

src_compile() {
	scons prefix="/usr" || die
}

src_install() {
	scons prefix="/usr" destdir="${D}" libdir="/$(get_libdir)" install || die

	find ${D} -name .sconsign -exec rm \{\} \;
	dodoc AUTHORS 		|| die "dodoc failed"
	dohtml doc/doc.html || die "dohtml failed"
}
