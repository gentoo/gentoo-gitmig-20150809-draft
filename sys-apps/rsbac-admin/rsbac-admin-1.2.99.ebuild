# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rsbac-admin/rsbac-admin-1.2.99.ebuild,v 1.1 2005/05/09 23:19:48 kang Exp $

inherit subversion

IUSE="debug pam"

# RSBAC Adming packet name
ADMIN=rsbac-admin-v${PV}

DESCRIPTION="Rule Set Based Access Control (RSBAC) Admin Tools"
HOMEPAGE="http://www.rsbac.org/ http://hardened.gentoo.org/rsbac"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-*"
NSS="1.2.5"

DEPEND="dev-util/dialog
	pam? ( sys-libs/pam )
	sys-apps/baselayout
	|| (
		>=sys-kernel/rsbac-sources-2.4.99
		>=sys-kernel/rsbac-dev-sources-2.6.99
	)"

RDEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	ESVN_REPO_URI="svn://rsbac.mprivacy-update.de/rsbac/rsbac-admin-v1.2.5"
	subversion_src_unpack
	cd ${WORKDIR}/${P}/${ADMIN}
}

src_compile() {
	cd ${WORKDIR}/${P}/${ADMIN}
	econf || die "cannot ./configure RSBAC Admin Tools."
	cd ${WORKDIR}/${ADMIN}/contrib/rsbac-klogd-2.0; econf || die "cannot ./configure rsbac-klogd"
	cd ${WORKDIR}/${ADMIN}/contrib/nss_rsbac; econf || die "cannot ./configure nss_rsbac"
	cd ${WORKDIR}/${ADMIN}
	emake || die "cannot make RSBAC Admin tools: Did you really already compiled
	a RSBAC-enabled kernel ? Please check the documentation at:
	http://hardened.gentoo.org/rsbac"
	emake -C contrib/rsbac-klogd-2.0 || die "cannot make rsbac-klogd"
	cd contrib/nss_rsbac
	LD="../../src/librsbac.so.$NSS" econf  || die "cannot conf nss_rsbac"
	cd ${WORKDIR}/${ADMIN}
	emake -C contrib/nss_rsbac || die "cannot make nss_rsbac"
	use pam && {
		emake -C contrib/pam_rsbac || die "cannot make pam_rsbac"
	}
	if use debug; then
		emake -C contrib/regression || die "cannot make regression"
	fi
}

src_install() {
	cd ${WORKDIR}/${ADMIN}
	einstall || die "cannot make install"
	einstall -C contrib/rsbac-klogd-2.0 || die "cannot install rsbac-klogd"
	einstall -C contrib/nss_rsbac || die "cannot install nss_rsbac"
	if use debug; then
		exeinto /usr/share/rsbac-admin-dev/regression
		doexe contrib/regression/*_test
	fi
	insinto /etc
	newins ${FILESDIR}/rsbac.conf rsbac.conf ${FILESDIR}/nsswitch.conf
	exeinto /etc/init.d
	newinitd ${FILESDIR}/rklogd.init rklogd
	use pam && {
		insinto /lib/security
		newins ${WORKDIR}/${ADMIN}/contrib/pam_rsbac/pam_rsbac.so pam_rsbac.so
	}
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
