# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rsbac-admin/rsbac-admin-1.2.5.ebuild,v 1.1 2005/10/07 15:39:05 kang Exp $

inherit eutils

IUSE="pam"

# RSBAC Adming packet name
#ADMIN=rsbac-admin-v${PV}

DESCRIPTION="Rule Set Based Access Control (RSBAC) Admin Tools"
HOMEPAGE="http://www.rsbac.org/ http://hardened.gentoo.org/rsbac"
SRC_URI="http://download.rsbac.org/code/${PV}/rsbac-admin-${PV}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
NSS="1.2.5"

DEPEND="dev-util/dialog
	pam? ( sys-libs/pam )
	sys-apps/baselayout"

RDEPEND=">=sys-libs/ncurses-5.2"

src_compile() {
	local rsbacmakeargs
	rsbacmakeargs="libs tools"
	use pam && {
		rsbacmakeargs="${makeargs} pam nss"
	}
	emake PREFIX=/usr ${rsbacmakeargs} || "cannot build (${rsbacmakeargs})"
}

src_install() {
	local rsabacinstallargs
	rsbacinstallargs="headers-install libs-install tools-install"
	use pam && {
		rsbacinstallargs="${rsbacinstallargs} pam-install nss-install"
	}
	make PREFIX=${D}/usr DESTDIR=${D} ${rsbacinstallargs}
	insinto /etc
	newins ${FILESDIR}/rsbac.conf rsbac.conf ${FILESDIR}/nsswitch.conf
	dodir /secoff
	keepdir /secoff
	dodir /secoff/log
	keepdir /secoff/log
}

pkg_postinst() {
	enewgroup secoff 400 || die "problem adding group secoff"
	enewuser secoff 400 /bin/bash /secoff secoff || die "problem adding user secoff"

	chmod 700 /secoff /secoff/log || die "problem changing permissions of /secoff and/or /secoff/log"
	chown secoff:secoff -R /secoff || die "problem changing ownership of /secoff"
}
