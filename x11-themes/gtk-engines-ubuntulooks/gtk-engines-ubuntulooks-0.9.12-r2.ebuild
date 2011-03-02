# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-ubuntulooks/gtk-engines-ubuntulooks-0.9.12-r2.ebuild,v 1.5 2011/03/02 19:29:01 signals Exp $

EAPI=2
inherit eutils

PATCH_LEVEL=11

MY_PN=${PN/gtk-engines-/}

DESCRIPTION="a derivative of the standard Clearlooks engine, using a more orange approach"
HOMEPAGE="http://packages.ubuntu.com/search?keywords=gtk2-engines-ubuntulooks"
SRC_URI="mirror://ubuntu/pool/main/u/${MY_PN}/${MY_PN}_${PV}.orig.tar.gz
	mirror://ubuntu/pool/main/u/${MY_PN}/${MY_PN}_${PV}-${PATCH_LEVEL}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_PN}-${PV}

src_prepare() {
	epatch "${WORKDIR}"/${MY_PN}_${PV}-${PATCH_LEVEL}.diff
	EPATCH_FORCE="yes" EPATCH_SUFFIX="patch" epatch debian/patches
}

src_configure() {
	econf --disable-dependency-tracking --enable-animation
}

src_compile() {
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README
	newdoc debian/changelog ChangeLog.debian
}
