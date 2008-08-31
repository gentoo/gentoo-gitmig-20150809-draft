# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/podsleuth/podsleuth-0.6.2.ebuild,v 1.1 2008/08/31 21:30:29 loki_val Exp $

inherit base autotools mono

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

PATCHES=( "${FILESDIR}/${P}-sgutils2.patch" )

src_unpack() {
	base_src_unpack
	cd "${S}"
	sed -i \
		-e '/AC_PROG_INSTALL/aAC_PROG_CC' \
		"${S}"/configure.ac || die "SED 404. FILE NOT FOUND"
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	econf --with-hal-callouts-dir=/usr/libexec
	emake -j1 || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
