# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rsbac-admin/rsbac-admin-1.2.4.ebuild,v 1.3 2005/04/04 11:25:06 kang Exp $

inherit eutils

IUSE="debug"

# RSBAC Adming packet name
ADMIN=rsbac-admin-v${PV}

DESCRIPTION="Rule Set Based Access Control (RSBAC) Admin Tools"
HOMEPAGE="http://www.rsbac.org/ http://hardened.gentoo.org/rsbac"
SRC_URI="http://rsbac.org/download/code/v${PV}/rsbac-admin-v${PV}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
NSS="1.2.4"

DEPEND="dev-util/dialog
	sys-libs/pam
	sys-apps/baselayout
	|| ( >=sys-kernel/rsbac-sources-2.4.29-r1
	>=sys-kernel/rsbac-dev-sources-2.6.10-r3 )"


RDEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	cd ${WORKDIR}
	unpack ${ADMIN}.tar.bz2 || die "cannot unpack rsbac-admin tool"
	cd ${WORKDIR}/${ADMIN}
}

src_compile() {
	cd ${WORKDIR}/${ADMIN}
	econf || die "cannot ./configure RSBAC Admin Tools."
	cd ${WORKDIR}/${ADMIN}/contrib/rsbac-klogd-2.0; econf || die "cannot ./configure rsbac-klogd"
	cd ${WORKDIR}/${ADMIN}/contrib/nss_rsbac; econf || die "cannot ./configure nss_rsbac"
	cd ${WORKDIR}/${ADMIN}
	emake || die "cannot make RSBAC Admin tools: Did you really already compiled
	a RSBAC-enabled kernel ? Please check the documentation at:
	http://hardened.gentoo.org/rsbac"
	emake -C contrib/rsbac-klogd-2.0 || die "cannot make rsbac-klogd"
	LD="../../src/librsbac.so.$NSS" econf contrib/nss_rsbac \
	|| die "cannot conf nss_rsbac"
	emake -C contrib/nss_rsbac || die "cannot make nss_rsbac"
	emake -C contrib/pam_rsbac || die "cannot make pam_rsbac"
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
	insinto /lib/security
	newins ${WORKDIR}/${ADMIN}/contrib/pam_rsbac/pam_rsbac.so

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
