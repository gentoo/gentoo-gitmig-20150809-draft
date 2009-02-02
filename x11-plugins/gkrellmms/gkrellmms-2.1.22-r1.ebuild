# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmms/gkrellmms-2.1.22-r1.ebuild,v 1.9 2009/02/02 17:08:05 drizzt Exp $

inherit eutils multilib toolchain-funcs

DESCRIPTION="A sweet plugin to control Audacious from GKrellM2"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz
	mirror://gentoo/${P}-audacious.patch.gz"
HOMEPAGE="http://gkrellm.luon.net/gkrellmms.phtml"

DEPEND=">=app-admin/gkrellm-2
	media-sound/audacious
	sys-apps/dbus"
# dbus dependency is because of audacious patch

RDEPEND="${DEPEND}"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ppc sparc x86"

S="${WORKDIR}"/${PN}

pkg_setup() {
	if has_version '<media-sound/audacious-1.5.0' && ! built_with_use media-sound/audacious dbus ; then
		eerror "${PN} needs media-sound/audacious built with"
		eerror "USE='dbus'. Please, reinstall it with dbus enabled"
		eerror "and try again."
		die "media-sound/audacious built without dbus USE flag"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${WORKDIR}"/${P}-audacious.patch
	epatch "${FILESDIR}"/${P}-ldflags.patch
}

src_compile() {
	tc-export CC
	emake USE_AUDACIOUS=1 || die
}

src_install () {
	exeinto /usr/"$(get_libdir)"/gkrellm2/plugins
	doexe gkrellmms.so
	dodoc README Changelog FAQ Themes
}
