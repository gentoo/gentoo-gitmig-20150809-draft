# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rhpxl/rhpxl-0.47.ebuild,v 1.1 2007/07/15 02:52:46 dberkholz Exp $

inherit eutils rpm

# Tag for which Fedora Core version it's from
FCVER="8"
# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="2"

DESCRIPTION="Python library for configuring and running X"
HOMEPAGE="http://fedora.redhat.com/projects/config-tools/"
SRC_URI="mirror://fedora/development/source/SRPMS/${P}-${RPMREV}.fc${FCVER}.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86 -s390"
IUSE=""
RDEPEND="dev-lang/python
	>=dev-python/pyxf86config-0.3.31
	dev-python/rhpl
	dev-libs/newt
	>=sys-apps/kudzu-1.2
	x11-base/xorg-server
	x11-libs/libXrandr"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_unpack() {
	rpm_src_unpack
	cd "${S}"
	epatch "${FILESDIR}"/0.32-use-radeon-ddc.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
