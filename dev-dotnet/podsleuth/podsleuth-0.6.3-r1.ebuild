# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/podsleuth/podsleuth-0.6.3-r1.ebuild,v 1.1 2008/12/14 17:03:53 loki_val Exp $

inherit mono base

DESCRIPTION="a tool to discover detailed model information about an Apple (TM) iPod (TM)."
HOMEPAGE="http://banshee-project.org/PodSleuth"
SRC_URI="http://banshee-project.org/files/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-1.1.10
	dev-dotnet/dbus-glib-sharp
	>=sys-apps/hal-0.5.6
	sys-apps/sg3_utils"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PATCHES=( "${FILESDIR}/${P}-libsgutils.patch" )

src_compile() {
	econf --with-hal-callouts-dir=/usr/libexec
	emake -j1 || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
