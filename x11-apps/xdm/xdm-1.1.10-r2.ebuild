# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xdm/xdm-1.1.10-r2.ebuild,v 1.6 2011/09/05 19:19:03 maekke Exp $

EAPI=3

inherit multilib xorg-2 pam systemd

DEFAULTVT="vt7"

DESCRIPTION="X.Org xdm application"

KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE="ipv6 pam"

RDEPEND="x11-apps/xrdb
	x11-libs/libXdmcp
	x11-libs/libXaw
	>=x11-apps/xinit-1.0.2-r3
	x11-libs/libXinerama
	x11-libs/libXmu
	x11-libs/libX11
	x11-libs/libXt
	x11-apps/sessreg
	x11-apps/xconsole
	pam? ( virtual/pam )"
DEPEND="${RDEPEND}
	x11-proto/xineramaproto
	x11-proto/xproto"

PATCHES=(
	"${FILESDIR}"/xwilling-hang.patch
	# bug #369531 (underlinking)
	"${FILESDIR}"/0001-Fix-missing-linking-dependency-on-ldl.patch
)

pkg_setup() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable ipv6)
		$(use_with pam)
		--with-default-vt=${DEFAULTVT}
		--with-xdmconfigdir=/etc/X11/xdm
	)
}

src_install() {
	xorg-2_src_install
	exeinto /usr/$(get_libdir)/X11/xdm
	doexe "${FILESDIR}"/Xsession || die
	if use pam; then
		# Use system-local-login to get pam_loginuid and pam_ck_connector from
		# pambase. This is required to get active ConsoleKit session since 0.4.2.
		pamd_mimic system-local-login xdm auth account session
	fi
	# Keep /var/lib/xdm. This is where authfiles are stored. See #286350.
	keepdir /var/lib/xdm

	systemd_dounit "${FILESDIR}"/xdm.service || die
}

pkg_postinst() {
	# Mea culpa, feel free to remove that after some time --mgorny.
	if [[ -L "${ROOT}"/etc/systemd/system/graphical.target.wants/${PN}'@tty7'.service ]]
	then
		ebegin "Renaming ${PN}@tty7.service to ${PN}.service"
		ln -s "${ROOT}"/lib/systemd/system/xdm.service \
			"${ROOT}"/etc/systemd/system/graphical.target.wants/${PN}.service && \
		rm -f "${ROOT}"/etc/systemd/system/graphical.target.wants/${PN}'@tty7'.service
		eend ${?} \
			"Please try to re-enable xdm.service"
	fi
}
