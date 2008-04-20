# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/emelfm2/emelfm2-0.4.ebuild,v 1.2 2008/04/20 16:52:43 drac Exp $

inherit eutils toolchain-funcs multilib

DESCRIPTION="A file manager that implements the popular two-pane design"
HOMEPAGE="http://emelfm2.net"
SRC_URI="http://${PN}.net/rel/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="acl unicode fam"

RESTRICT="test"

RDEPEND=">=x11-libs/gtk+-2.12
	fam? ( virtual/fam )
	acl? ( sys-apps/acl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:${PN}/${PN}_48.png:${PN}:" \
		docs/desktop_environment/${PN}.desktop || die "sed failed."
	sed -e "s:(PREFIX)/lib:(PREFIX)/$(get_libdir):" -e "s:strip:true:g" \
		-i Makefile || die "sed failed."
}

src_compile() {
	# These options need >=x11-libs/gtk-2.12 which we depend upon
	local myconf="USE_LATEST=1 WITH_TRANSPARENCY=1"

	if use acl; then
		myconf="${myconf} WITH_ACL=1"
	fi

	if use unicode; then
		myconf="${myconf} FILES_UTF8ONLY=1"
	fi

	if use fam; then
		if has_version "app-admin/gamin"; then
			myconf="${myconf} USE_GAMIN=1"
		else
			myconf="${myconf} USE_FAM=1"
		fi
	else
		myconf="${myconf} USE_FAM=0"
	fi

	tc-export CC
	emake ICON_DIR="/usr/share/pixmaps/${PN}" ${myconf} || die "emake failed."
}

src_install() {
	emake PREFIX="${D}/usr" install || die "emake install failed."
	newicon icons/${PN}_48.png ${PN}.png
	prepalldocs
}
