# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rhpxl/rhpxl-0.51.ebuild,v 1.1 2008/03/20 00:17:09 dberkholz Exp $

inherit eutils rpm

# Tag for which Fedora Core version it's from
FCVER="9"
# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="1"

DESCRIPTION="Python library for configuring and running X"
HOMEPAGE="http://fedoraproject.org/wiki/SystemConfig/"
SRC_URI="mirror://fedora/development/source/SRPMS/${P}-${RPMREV}.fc${FCVER}.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc -s390 ~x86"
IUSE=""
RDEPEND="dev-lang/python
	>=dev-python/pyxf86config-0.3.31
	dev-python/rhpl
	dev-libs/newt
	>=sys-apps/kudzu-1.2.75
	x11-base/xorg-server
	x11-libs/libXrandr"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_unpack() {
	rpm_src_unpack
	cd "${S}"
	epatch "${FILESDIR}"/0.32-use-radeon-ddc.patch
	epatch "${FILESDIR}"/rhpxl-0.51-serverflags.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
