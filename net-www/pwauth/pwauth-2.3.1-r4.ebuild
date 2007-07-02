# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/pwauth/pwauth-2.3.1-r4.ebuild,v 1.1 2007/07/02 10:19:20 flameeyes Exp $

inherit eutils toolchain-funcs pam

DESCRIPTION="A Unix Web Authenticator"
HOMEPAGE="http://www.unixpapa.com/pwauth/"
SRC_URI="http://www.unixpapa.com/software/${P}.tar.gz"

LICENSE="Apache-1.1"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="faillog pam ignore-case domain-aware"
SLOT="0"

DEPEND="pam? ( virtual/pam )"

pkg_setup() {
	local OPTS

	einfo "You can configure various build time options with ENV variables:"
	einfo
	einfo "    PWAUTH_FAILLOG      Path to logfile for login failures"
	einfo "                        (default: /var/log/pwauth.log)"
	einfo "    PWAUTH_SERVERUIDS   Comma seperated list of UIDs allowed to run pwauth"
	einfo "                        (default: 81)"
	einfo "    PWAUTH_MINUID       Minimum UID for which authentication will succeed"
	einfo "                        (default: 1000)"
	einfo

	PWAUTH_FAILLOG="${PWAUTH_FAILLOG:-/var/log/pwauth.log}"
	PWAUTH_SERVERUIDS="${PWAUTH_SERVERUIDS:-81}"
	PWAUTH_MINUID="${PWAUTH_MINUID:-1000}"

	OPTS="${OPTS} -DSERVER_UIDS=${PWAUTH_SERVERUIDS}"
	OPTS="${OPTS} -DMIN_UNIX_UID=${PWAUTH_MINUID}"

	if useq faillog; then
		OPTS="${OPTS} -DFAILLOG_PWAUTH"
		OPTS="${OPTS} -DPATH_FAILLOG=\"\\\"${PWAUTH_FAILLOG}\\\"\""
	fi

	if useq pam; then
		OPTS="${OPTS} -DPAM"
		LDFLAGS="-lpam"
	else
		OPTS="${OPTS} -DSHADOW_SUN"
		LDFLAGS="-lcrypt"
	fi

	if useq ignore-case; then
		OPTS="${OPTS} -DIGNORE_CASE"
	fi

	if useq domain-aware; then
		OPTS="${OPTS} -DOMAIN_AWARE"
	fi

	CC=$(tc-getCC)
	CFLAGS="${CFLAGS} ${OPTS}"
}

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S} || die "cd to $s failed"

	epatch "${FILESDIR}"/pwauth-gentoo.patch
}

src_install() {
	dosbin pwauth unixgroup
	fperms 4755 /usr/sbin/pwauth

	useq pam && newpamd ${FILESDIR}/pwauth.pam-include.1 pwauth

	dodoc CHANGES FORM_AUTH INSTALL README
}
