# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rsbac-admin/rsbac-admin-1.2.99.ebuild,v 1.6 2007/07/12 05:10:21 mr_bones_ Exp $

inherit eutils subversion

IUSE="pam"

# RSBAC Adming packet name
#ADMIN=rsbac-admin-v${PV}

DESCRIPTION="Rule Set Based Access Control (RSBAC) Admin Tools"
HOMEPAGE="http://www.rsbac.org/ http://hardened.gentoo.org/rsbac"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
NSS="1.2.5"

DEPEND="dev-util/dialog
	pam? ( sys-libs/pam )
	sys-apps/baselayout"

RDEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	ESVN_REPO_URI="svn://rsbac.de/rsbac1/rsbac-admin/trunk"
	subversion_src_unpack
	cd ${WORKDIR}/${P}/${ADMIN}
}

src_compile() {
	local rsbacmakeargs
	rsbacmakeargs="libs tools"
	use pam && {
		rsbacmakeargs="${makeargs} pam nss"
	}
	emake PREFIX=/usr ${rsbacmakeargs} || die "cannot build (${rsbacmakeargs})"
}

src_install() {
	local rsabacinstallargs
	rsbacinstallargs="headers-install libs-install tools-install"
	use pam && {
		rsbacinstallargs="${rsbacinstallargs} pam-install nss-install"
	}
	make PREFIX=${D}/usr DESTDIR=${D} ${rsbacinstallargs} || \
	die "cannot install (${rsbacinstallargs})"
	insinto /etc
	newins ${FILESDIR}/rsbac.conf rsbac.conf ${FILESDIR}/nsswitch.conf
	dodir /secoff
	keepdir /secoff
	dodir /var/log/rsbac
	keepdir /var/log/rsbac
}

pkg_postinst() {
	enewgroup secoff 400 || die "problem adding group secoff"
	enewuser secoff 400 /bin/bash /secoff secoff || \
	die "problem adding user secoff"
	enewgroup audit 404 || die "problem adding group audit"
	enewuser audit 404 -1 /dev/null audit || \
	die "problem adding user audit"

	chmod 700 /secoff /var/log/rsbac ||  \
	die "problem changing permissions of /secoff and/or /secoff/log"
	chown secoff:secoff -R /secoff || \
	die "problem changing ownership of /secoff"
	einfo "It is suggested to run (for example) a separate copy of syslog-ng to"
	einfo "log RSBAC messages, as user audit (uid 404) instead of using the deprecated"
	einfo "rklogd. See http://rsbac.org/documentation/administration_examples/syslog-ng"
	einfo "for more information."
}
