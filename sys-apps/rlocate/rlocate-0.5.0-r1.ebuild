# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rlocate/rlocate-0.5.0-r1.ebuild,v 1.2 2006/04/16 01:51:32 vapier Exp $

inherit eutils linux-mod

DESCRIPTION="locate implementation that is always up-to-date"
HOMEPAGE="http://rlocate.sourceforge.net/"
SRC_URI="mirror://sourceforge/rlocate/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="!sys-apps/slocate"

pkg_setup() {
	MODULE_NAMES="rlocate(misc:${S}/src/rlocate-module)"
	CONFIG_CHECK="SECURITY"
	SECURITY_ERROR="You need to select the \"Enable different security models\" option in the kernel configuration (CONFIG_SECURITY)."
	BUILD_TARGETS="all"
	linux-mod_pkg_setup

	enewgroup locate
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.5.0-build.patch
	epatch "${FILESDIR}"/${PN}-0.5.0-settings.patch
}

src_compile() {
	econf \
		--with-kernel=${KV_DIR} \
		--with-rlocate-group=locate \
		|| die
	emake || die
	linux-mod_src_compile
}

src_install() {
	make install DESTDIR="${D}" || die
	newinitd "${FILESDIR}"/rlocated.rc rlocated
	linux-mod_src_install
	dodoc AUTHORS ChangeLog* NEWS README
}
