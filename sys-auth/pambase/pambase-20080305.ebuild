# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pambase/pambase-20080305.ebuild,v 1.1 2008/03/05 17:06:15 flameeyes Exp $

inherit eutils

DESCRIPTION="PAM base configuration files"
SRC_URI="http://www.flameeyes.eu/gentoo-distfiles/${P}.tar.bz2"
HOMEPAGE="http://www.gentoo.org/proj/en/base/pam/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~hppa ~ppc64 ~x86"
IUSE="debug cracklib consolekit gnome selinux"

RDEPEND="
	|| (
		>=sys-libs/pam-0.99.9.0-r1
		( sys-auth/openpam
		  || ( sys-freebsd/freebsd-pam-modules sys-netbsd/netbsd-pam-modules )
		)
	)
	cracklib? ( >=sys-libs/pam-0.99 )
	consolekit? ( sys-auth/consolekit )
	gnome? ( >=gnome-base/gnome-keyring-2.20 )
	selinux? ( >=sys-libs/pam-0.99 )
	!<sys-freebsd/freebsd-pam-modules-6.2-r1
	!<sys-libs/pam-0.99.9.0-r1"
DEPEND=""

RESTRICT="binchecks"

pkg_setup() {
	if use cracklib && ! built_with_use sys-libs/pam cracklib; then
		eerror "To enable cracklib support in the main PAM configuration"
		eerror "you need to enable cracklib USE flag on sys-libs/pam"
		eerror "first."
		die "Missing pam_cracklib"
	fi

	if use selinux && ! built_with_use sys-libs/pam selinux; then
		eerror "To enable selinux support in the main PAM configuration"
		eerror "you need to enable selinux USE flag on sys-libs/pam"
		eerror "first."
		die "Missing pam_selinux"
	fi

	if use consolekit && ! built_with_use sys-auth/consolekit pam; then
		eerror "To enable ConsoleKit support in the main PAM configuration"
		eerror "you need to enable pam USE flag on sys-auth/consolekit"
		eerror "first."
		die "Missing pam_ck_connector"
	fi

	if use gnome && ! built_with_use gnome-base/gnome-keyring pam; then
		eerror "To enable GNOME Keyring support in the main PAM configuration"
		eerror "you need to enable pam USE flag on gnome-base/gnome-keyring"
		eerror "first."
		die "Missing pam_gnome_keyring"
	fi
}

src_compile() {
	has_version sys-libs/pam && implementation="linux-pam"
	has_version sys-auth/openpam && implementation="openpam"

	emake \
		GIT=true \
		DEBUG=$(use debug && echo yes || echo no) \
		CRACKLIB=$(use cracklib && echo yes || echo no) \
		CONSOLEKIT=$(use consolekit && echo yes || echo no) \
		GNOME_KEYRING=$(use gnome && echo yes || echo no) \
		SELINUX=$(use selinux && echo yes || echo no) \
		IMPLEMENTATION=${implementation} \
		|| die "emake failed"
}

src_install() {
	emake GIT=true DESTDIR="${D}" install || die "emake install failed"
}
