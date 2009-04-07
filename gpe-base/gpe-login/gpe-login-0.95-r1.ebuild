# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-base/gpe-login/gpe-login-0.95-r1.ebuild,v 1.1 2009/04/07 15:28:41 miknix Exp $

GPE_TARBALL_SUFFIX="bz2"
inherit gpe eutils

DESCRIPTION="The GPE user login screen"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="branding"

DEPEND="${DEPEND}
	>=gpe-base/libgpewidget-0.102"
RDEPEND="${RDEPEND}
	${DEPEND}
	x11-misc/xkbd
	gpe-utils/gpe-ownerinfo"

src_unpack() {
	gpe_src_unpack "$@"

	# Patch login to show up a beaty gentoo logo (if found)
	# solar says conditional patching is bad
	epatch "${FILESDIR}/gpe-login-0.95-gentoologo.patch"

	# Use our gentooish gpe-login.setup instead
	cp "${FILESDIR}/gpe-login.setup-gentoo" gpe-login.setup \
		|| die "Cannot replace gpe-login.setup"
	chmod 0755 gpe-login.setup \
		|| die "Cannot chmod gpe-login.setup"
	# This file is device specific, dont install it
	sed -i -e 's;gpe-login.keylaunchrc;;' Makefile.in \
		|| die "Sed failed"
}

src_install() {
	gpe_src_install "$@"

	insinto /etc/X11/
	newins "${FILESDIR}/gpe-login.geometry-gentoo" gpe-login.geometry
	insinto /etc/gpe/
	newins "${FILESDIR}/locale.default-gentoo" locale.default

	# Install the gentoo logo into pixmaps, see above
	if use branding; then
		insinto /usr/share/pixmaps/
		newins "${FILESDIR}/gentoo-badge2.png" gpe-login-gentoo.png
	fi
}

pkg_postinst() {
	einfo "Have a look on the following files to fine tune"
	einfo "your brand new login manager:"
	einfo "/etc/X11/gpe-login.setup"
	einfo "/etc/X11/gpe-login.geometry"
	einfo "/etc/gpe/gpe-login.conf"
	einfo "/etc/gpe/locale.default"
}
