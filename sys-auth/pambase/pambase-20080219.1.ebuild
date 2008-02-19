# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pambase/pambase-20080219.1.ebuild,v 1.1 2008/02/19 22:39:42 flameeyes Exp $

inherit eutils

DESCRIPTION="PAM base configuration files"
SRC_URI="http://www.flameeyes.eu/gentoo-distfiles/${P}.tar.bz2"
HOMEPAGE="http://www.gentoo.org/proj/en/pam/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug cracklib selinux"

RDEPEND="
	|| (
		>=sys-libs/pam-0.99.9.0-r1
		( sys-auth/openpam
		  || ( sys-freebsd/freebsd-pam-modules sys-netbsd/netbsd-pam-modules )
		)
	)
	cracklib? ( >=sys-libs/pam-0.99 )
	selinux? ( >=sys-libs/pam-0.99 )
	!<sys-freebsd/freebsd-pam-modules-6.2-r1
	!<sys-libs/pam-0.99.9.0-r1"

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
}

src_compile() {
	has_version sys-libs/pam && implementation="linux-pam"
	has_version sys-auth/openpam && implementation="openpam"

	emake \
		DEBUG=$(use debug && echo yes || echo no) \
		CRACKLIB=$(use cracklib && echo yes || echo no) \
		SELINUX=$(use selinux && echo yes || echo no) \
		IMPLEMENTATION=${implementation} \
		|| die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
