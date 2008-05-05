# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/slim/slim-1.3.0-r1.ebuild,v 1.5 2008/05/05 21:30:13 drac Exp $

inherit eutils toolchain-funcs pam

DESCRIPTION="Simple Login Manager"
HOMEPAGE="http://slim.berlios.de"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE="pam"

DEPEND="x11-proto/xproto
	x11-libs/libXmu
	x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXft
	media-libs/libpng
	media-libs/jpeg
	pam? ( virtual/pam )"
RDEPEND="${DEPEND}
	media-fonts/corefonts"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch

	# respect C[XX]FLAGS, fix crosscompile,
	# fix linking order for --as-needed"
	sed -i -e "s:^CXX=.*:CXX=$(tc-getCXX) ${CXXFLAGS}:" \
		-e "s:^CC=.*:CC=$(tc-getCC) ${CFLAGS}:" \
		-e "s:^MANDIR=.*:MANDIR=/usr/share/man:" \
		-e "s:/usr/X11R6:/usr:" \
		-e "s:^\t\(.*\)\ \$(LDFLAGS)\ \(.*\):\t\1\ \2\ \$(LDFLAGS):g" \
		Makefile || die 'sed failed in Makefile'

	# Remove all X11R6 references from slim.conf
	# Set slim to daemon mode as default to stop xdm runscript from throwing errors on stop
	# Set the default logfile to /dev/null to avoid cluttering up the harddisk
	# as slim puts a lot of garbage in its logfile
	# Make slim honor XSESSION in /etc/rc.conf by default.
	sed -i -e 's#X11R6/##g' -e 's#/usr/bin:##' \
		-e 's/# daemon/daemon/' \
		-e 's#/var/log/slim.log#/dev/null#g' \
		-e '/^login_cmd.*/s#exec /bin/bash.*#exec /bin/bash -login /etc/X11/xinit/xinitrc#' \
		slim.conf || die "sed failed in slim.conf"
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
	elog "If you want to use .xinitrc in the user's home directory for session management"
	elog "instead, see README and xinitrc.sample in /usr/share/doc/${PF}."
	elog "and change your login_cmd in /etc/slim.conf accordingly."
	elog
}
