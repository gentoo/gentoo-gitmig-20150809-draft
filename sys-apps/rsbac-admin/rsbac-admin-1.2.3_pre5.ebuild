# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rsbac-admin/rsbac-admin-1.2.3_pre5.ebuild,v 1.3 2004/07/15 02:30:02 agriffis Exp $

IUSE=""

# RSBAC Adming packet name
RSBACV=1.2.3
REL="-pre5"

DESCRIPTION="RSBAC Admin Tools"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/rsbac/"
SRC_URI="mirror://rsbac-admin-v${RSBACV}${REL}.tar.bz2  http://zeus.polsl.gliwice.pl/~albeiro/rsbac/v1.2.3/rsbac-admin-v${RSBACV}${REL}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="dev-util/dialog
		>=sys-kernel/rsbac-dev-sources-2.6.5"
RDEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	cd ${WORKDIR}
	unpack rsbac-admin-v${RSBACV}${REL}.tar.bz2 || die "cannot unpack rsbac-admin tool"

}

src_compile() {
	cd ${WORKDIR}/rsbac-admin-v${RSBACV}
	econf || die "cannot ./configure RSBAC Admin Tools"
	cd contrib/rsbac-klogd-2.0; econf || die "cannot ./configure rsbac-klogd"
	cd ${WORKDIR}/rsbac-admin-v${RSBACV}
	emake || die "cannot make RSBAC Admin tools: Did you really already compiled a RSBAC-enabled kernel ? Please check the documentation at: http://hardened.gentoo.org/rsbac"

	emake -C contrib/rsbac-klogd-2.0 || die "cannot make rsbac-klogd"
}

src_install() {
	cd ${WORKDIR}/rsbac-admin-v${RSBACV}
	einstall || die "cannot make install"
	einstall -C contrib/rsbac-klogd-2.0 || die "cannot install rsbac-klogd"
	instinto /etc
	newinst ${FILESDIR}/rsbac.conf rsbac.conf
	exeinto /etc/init.d
	newexe ${FILESDIR}/rklogd.init rklogd
	dodir /secoff
	dodir /secoff/log
	keepdir /secoff
	ewarn "Please see http://www.gentoo.org/proj/en/hardened/rsbac and emerge the corresponding rsbac-dev-sources before you start using RSBAC"
}

pkg_postinst() {
	if ! groupmod secoff; then
		groupadd -g 400 secoff || die "problem adding group secoff"
	fi

	if ! id secoff; then
		useradd -c "Security Officer" -d /secoff -s /bin/bash -g secoff -u 400 secoff
		assert "problem adding user secoff"
		chmod 700 /secoff /secoff/log || die "problem changing permissions of /secoff and /secoff/log"
		chown secoff:secoff -R /secoff || die "problem changing ownership of /secoff"
	fi
}
