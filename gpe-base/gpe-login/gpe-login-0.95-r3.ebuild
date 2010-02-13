# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-base/gpe-login/gpe-login-0.95-r3.ebuild,v 1.2 2010/02/13 11:58:49 miknix Exp $

GPE_TARBALL_SUFFIX="bz2"
inherit gpe eutils autotools

DESCRIPTION="The GPE user login screen"
SRC_URI="${SRC_URI}
mirror://gentoo/${PN}-gentoo.png.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="branding"

DEPEND="${DEPEND} gpe-base/libgpewidget"
RDEPEND="${RDEPEND} ${DEPEND}
	x11-misc/xkbd
	gpe-utils/gpe-ownerinfo
	x11-wm/matchbox
	sys-apps/dbus"

src_unpack() {
	local gentoo_files="./gpe-login.setup
	                    ./gpe-login.xinit
						./gpe-login.session
						X11/gpe-login.pre-session"

	gpe_src_unpack "$@"

	# Patch login to show up a beaty gentoo logo (if found)
	# solar says conditional patching is bad
	epatch "${FILESDIR}/gpe-login-0.95-gentoologo.patch"

	# Use our gentooish scripts instead
	for gfile in $gentoo_files; do
		einfo "Replacing ${gfile}"
		cp "${FILESDIR}/${gfile/[^\/]*\//}-gentoo" "${gfile}" \
			|| die "Replace ${gfile} fail"
		chmod 0755 ${gfile} || die "Cannot chmod ${gfile}"
	done

	# This patch removes a lot of ugly files and fixes
	# the X11/Xinit.d path
	epatch "${FILESDIR}/${P}-cleanup.patch"

	eautoreconf
}

src_install() {
	gpe_src_install "$@"

	insinto /etc/X11/
	newins "${FILESDIR}/gpe-login.geometry-gentoo" gpe-login.geometry
	exeinto /etc/X11/
	newexe "${FILESDIR}/gpe-login.xsession-gentoo" Xsession
	exeinto /etc/X11/Xsession.d/
	newexe "${FILESDIR}/windowmanager.xsessiond-gentoo" 99xWindowManager
	insinto /etc/gpe/
	newins "${FILESDIR}/locale.default-gentoo" locale.default

	# Install the gentoo logo into pixmaps, see above
	if use branding; then
		insinto /usr/share/pixmaps/
		doins "${WORKDIR}/${PN}-gentoo.png"
	fi
}

pkg_postinst() {
	einfo "Have a look on the following files to fine tune"
	einfo "your brand new login manager:"
	einfo "/etc/X11/gpe-login.setup"
	einfo "/etc/X11/gpe-login.geometry"
	einfo "/etc/X11/gpe-login.pre-session"
	einfo "/etc/gpe/gpe-login.conf"
	einfo "/etc/gpe/locale.default"
}
