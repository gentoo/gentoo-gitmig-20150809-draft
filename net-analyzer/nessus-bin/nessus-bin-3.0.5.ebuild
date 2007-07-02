# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-bin/nessus-bin-3.0.5.ebuild,v 1.4 2007/07/02 14:39:26 peper Exp $

inherit rpm

MY_P="Nessus-${PV}-suse10.0.i586"
# We are using SuSE's binary

DESCRIPTION="A remote security scanner for Linux"
HOMEPAGE="http://www.nessus.org"
SRC_URI="${MY_P}.rpm"
RESTRICT="mirror fetch strip"

LICENSE="Nessus-EULA"
SLOT="0"
KEYWORDS="x86"
IUSE="X"

DEPEND="=sys-libs/db-4.3*
	dev-libs/openssl"

PDEPEND="X? ( net-analyzer/nessus-client )"

pkg_nofetch() {
	einfo "Please download ${MY_P}.rpm from ${HOMEPAGE}/download"
	einfo "The archive should then be placed into ${DISTDIR}."
}

pkg_setup() {
	case ${CHOST} in
		i586-pc-linux-gnu*)	einfo "Found compatible architecture." ;;
		i686-pc-linux-gnu*)	einfo "Found compatible architecture." ;;
		*)			die "No compatible architecture found." ;;
	esac
}

src_install() {
	# copy files
	cp -pPR "${WORKDIR}"/opt "${D}"

	# make sure these directories do not vanish
	# nessus will not run properly without them
	keepdir /opt/nessus/etc/nessus
	keepdir /opt/nessus/var/nessus/jobs
	keepdir /opt/nessus/var/nessus/logs
	keepdir /opt/nessus/var/nessus/tmp
	keepdir /opt/nessus/var/nessus/users

	# add /opt/nessus/lib to LD_PATH
	# nessus will not run properly without it
	doenvd "${FILESDIR}"/90nessus-bin

	# we have /bin/gzip, not /usr/bin/gzip
	sed -i -e "s:/usr/bin/gzip:/bin/gzip:g" \
		"${D}"/opt/nessus/sbin/nessus-update-plugins

	# init script
	newinitd "${FILESDIR}"/nessusd-initd nessusd-bin
}

pkg_postinst() {
	elog "You can get started running the following commands:"
	elog "/opt/nessus/sbin/nessus-add-first-user"
	elog "/opt/nessus/sbin/nessus-mkcert"
	elog "/etc/init.d/nessusd-bin start"
	elog
	elog "For more information about nessus, please visit"
	elog "${HOMEPAGE}/documentation/"
}
