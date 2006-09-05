# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rhpxl/rhpxl-0.32.ebuild,v 1.1 2006/09/05 21:20:35 dberkholz Exp $

inherit rpm

# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="1"

DESCRIPTION="Python library for configuring and running X"
HOMEPAGE="http://fedora.redhat.com/projects/config-tools/"
SRC_URI="mirror://fedora/development/source/SRPMS/${P}-${RPMREV}.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86 -s390"
IUSE=""
RDEPEND="dev-lang/python
	dev-python/pyxf86config
	dev-python/rhpl
	dev-libs/newt
	>=sys-apps/kudzu-1.2
	x11-base/xorg-server
	x11-libs/libXrandr"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
