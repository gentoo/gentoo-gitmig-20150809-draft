# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/boo/boo-0.9.0.3203.ebuild,v 1.1 2009/05/03 21:13:51 loki_val Exp $

EAPI=2

inherit multilib mono fdo-mime eutils

DESCRIPTION="A wrist friendly language for the CLI"
HOMEPAGE="http://boo.codehaus.org/"
SRC_URI="http://dist.codehaus.org/boo/distributions/${P}-2-src.zip"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-2.0
	x11-libs/gtksourceview:1.0"
DEPEND="${RDEPEND}
	!!<${CATEGORY}/${P}
	x11-misc/shared-mime-info
	app-arch/unzip
	>=dev-dotnet/nant-0.86_beta1"

MAKEOPTS="${MAKEOPTS} -j1"

RESTRICT="test"

src_prepare() {
	sed -i -e 's: Boo.Microsoft.Build.Tasks, update-vs2005-env,::' default.build || die
	sed -i -e 's@${libdir}/boo@${libdir}/mono/boo@g' \
		extras/boo.pc.in || die
}

src_compile() {
	nant	-t:mono-2.0  \
		-D:install.prefix=/usr \
		-D:install.libdir=/usr/$(get_libdir) \
		set-release-configuration all|| die "Compilation failed"
}

src_install() {
	nant install	-D:install.buildroot="${D}" \
			-D:install.prefix="${D}"/usr \
			-D:install.share="${D}"/usr/share \
			-D:install.libdir="${D}"/usr/lib \
			-D:install.bindir="${D}/usr/bin" \
			-D:fakeroot.sharedmime="${D}"/usr \
			-D:fakeroot.gsv="${D}"/usr \
			|| die "install failed"
	rm -rf "${D}"/usr/share/gtksourceview-1.0 || die
	mono_multilib_comply
}

pkg_postinst() {
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
}
