# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rsbac-admin/rsbac-admin-1.2.3.ebuild,v 1.4 2004/08/02 01:38:16 kang Exp $

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

DEPEND="dev-util/dialog
	|| ( >=sys-kernel/rsbac-sources-2.4.26
	>=sys-kernel/rsbac-dev-sources-2.6.7 )"


RDEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	cd ${WORKDIR}
	unpack ${ADMIN}.tar.bz2 || die "cannot unpack rsbac-admin tool"
}

src_compile() {
	cd ${WORKDIR}/${ADMIN}
	econf || die "cannot ./configure RSBAC Admin Tools."
	cd contrib/rsbac-klogd-2.0; econf || die "cannot ./configure rsbac-klogd"
	cd ${WORKDIR}/${ADMIN}
	emake || die "cannot make RSBAC Admin tools: Did you really already compiled a RSBAC-enabled kernel ? Please check the documentation at: http://hardened.gentoo.org/rsbac"
	emake -C contrib/rsbac-klogd-2.0 || die "cannot make rsbac-klogd"
	if use debug; then
		emake -C contrib/regression || die "cannot make regression"
	fi
}

src_install() {
	cd ${WORKDIR}/${ADMIN}
	einstall || die "cannot make install"
	einstall -C contrib/rsbac-klogd-2.0 || die "cannot install rsbac-klogd"
	if use debug; then
		exeinto /usr/share/rsbac-admin-dev/regression
		doexe contrib/regression/*_test
	fi
	insinto /etc
	newins ${FILESDIR}/rsbac.conf rsbac.conf
	exeinto /etc/init.d
	newinitd ${FILESDIR}/rklogd.init rklogd

	dodir /secoff
	keepdir /secoff
	dodir /secoff/log
	keepdir /secoff/log
}

pkg_postinst() {
	if ! groupmod secoff; then
		enewgroup secoff 400 || die "problem adding group secoff"
	fi

	if ! id secoff; then
		enewuser secoff 400 /bin/bash /secoff secoff || die "problem adding user secoff"
	fi

	chmod 700 /secoff /secoff/log || die "problem changing permissions of /secoff and/or /secoff/log"
	chown secoff:secoff -R /secoff || die "problem changing ownership of /secoff"
}
