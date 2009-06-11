# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/podsleuth/podsleuth-0.6.4-r1.ebuild,v 1.2 2009/06/11 14:01:36 fauli Exp $

EAPI=2

inherit mono

DESCRIPTION="a tool to discover detailed model information about an Apple (TM) iPod (TM)."
HOMEPAGE="http://banshee-project.org/PodSleuth"
SRC_URI="http://banshee-project.org/files/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND=">=dev-lang/mono-2.0
	dev-dotnet/dbus-glib-sharp
	>=sys-apps/hal-0.5.6
	>=sys-apps/sg3_utils-1.27"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	# Bug 271597
	sed -i -e 's:target="libsgutils.so.1":target="libsgutils.so.2":' \
		src/PodSleuth/PodSleuth.dll.config.in || die
}

src_configure() {
	econf --with-hal-callouts-dir=/usr/libexec
}

src_compile() {
	emake -j1 || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
	mono_multilib_comply
}
