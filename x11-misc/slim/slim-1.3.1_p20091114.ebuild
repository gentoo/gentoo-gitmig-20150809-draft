# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/slim/slim-1.3.1_p20091114.ebuild,v 1.1 2010/03/28 03:25:25 darkside Exp $

EAPI=2

inherit toolchain-funcs pam eutils

DESCRIPTION="Simple Login Manager"
HOMEPAGE="http://slim.berlios.de"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="branding screenshot pam"

DEPEND="x11-proto/xproto
	x11-libs/libXmu
	x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXft
	media-libs/libpng
	media-libs/jpeg
	pam? ( virtual/pam )"
RDEPEND="${DEPEND}
	x11-apps/sessreg
	screenshot? ( media-gfx/imagemagick )
	branding? ( >=x11-themes/slim-themes-1.2.3a-r3 )"

src_prepare() {
	# respect C[XX]FLAGS, fix crosscompile,
	# fix linking order for --as-needed"
	sed -i -e "s:^CXX=.*:CXX=$(tc-getCXX) ${CXXFLAGS}:" \
		-e "s:^CC=.*:CC=$(tc-getCC) ${CFLAGS}:" \
		-e "s:^MANDIR=.*:MANDIR=/usr/share/man:" \
		-e "s:^\t\(.*\)\ \$(LDFLAGS)\ \(.*\):\t\1\ \2\ \$(LDFLAGS):g" \
		-r -e "s:^LDFLAGS=(.*):LDFLAGS=\1 ${LDFLAGS}:" \
		Makefile || die "sed failed in Makefile"
	epatch "${FILESDIR}/${PN}-1.3.1-config.diff"

	if use branding; then
		sed -i -e 's/  default/  slim-gentoo-simple/' slim.conf || die
	fi

	# Gentoo bug 297655
	epatch "${FILESDIR}/14509-fix-keyboard-in-tty-from-which-${PN}-is-lauched.patch"
	# Upstream bug #15287
	epatch "${FILESDIR}/15287-fix-pam-authentication-with-pam_unix2.patch"
	# Gentoo Bug 261713
	epatch "${FILESDIR}/261713-restart-xserver-if-killed.patch"
}

src_compile() {
	if use pam ; then
		emake USE_PAM=1 || die "emake failed."
	else
		emake || die "emake failed."
	fi
}

src_install() {
	if use pam ; then
		emake USE_PAM=1 DESTDIR="${D}" install || die "emake install failed."
		pamd_mimic_system slim auth account password session
	else
		emake DESTDIR="${D}" install || die "emake install failed."
	fi

	insinto /etc/logrotate.d
	newins "${FILESDIR}/slim.logrotate" slim || die "newins failed"

	dodoc xinitrc.sample ChangeLog README TODO THEMES
}

pkg_postinst() {
	elog
	elog "The configuration file is located at /etc/slim.conf."
	elog
	elog "If you wish ${PN} to start automatically, set DISPLAYMANAGER=\"${PN}\" "
	elog "in /etc/conf.d/xdm and run \"rc-update add xdm default\"."
	elog "By default, ${PN} will use default XSESSION value set in /etc/rc.conf."
	elog
	elog "If you want to use .xinitrc in the user's home directory for session"
	elog "management instead, see README and xinitrc.sample in"
	elog "/usr/share/doc/${PF} and change your login_cmd in /etc/slim.conf"
	elog "accordingly."
	elog
	if ! use pam; then
		elog "You have merged ${PN} without USE=pam, this will cause ${PN} to fall back to"
		elog "the console when restarting your window manager. If this is not"
		elog "desired, then please remerge ${PN} with USE=pam"
	fi
}
