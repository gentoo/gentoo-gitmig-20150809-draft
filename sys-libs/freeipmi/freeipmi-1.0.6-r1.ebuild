# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/freeipmi/freeipmi-1.0.6-r1.ebuild,v 1.1 2011/09/07 06:20:45 flameeyes Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="Provides Remote-Console and System Management Software as per IPMI v1.5/2.0"
HOMEPAGE="http://www.gnu.org/software/freeipmi/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	http://ftp.gluster.com/pub/${PN}/${PV}/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="dev-libs/libgcrypt"
DEPEND="${RDEPEND}
		virtual/os-headers"

src_prepare() {
	# Fix build mistake, only causes warnings but at least stop it.
	sed -i -e '/-module/d' "${S}"/libfreeipmi/src/Makefile.am || die

	epatch "${FILESDIR}"/${PN}-1.0.5-strictaliasing.patch
	epatch "${FILESDIR}"/${P}-bmc-watchdog-pidfile.patch

	AT_M4DIR="config" eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		--disable-dependency-tracking \
		--enable-fast-install \
		--disable-static \
		--disable-init-scripts \
		--enable-logrotate-config \
		--localstatedir=/var
}

# There are no tests
src_test() { :; }

src_install() {
	emake DESTDIR="${D}" docdir="/usr/share/doc/${PF}" install || die "emake install failed"
	find "${D}" -name '*.la' -delete

	# freeipmi by defaults install _all_ commands to /usr/sbin, but
	# quite a few can be run remotely as standard user, so move them
	# in /usr/bin afterwards.
	dodir /usr/bin
	for file in ipmi{detect,ping,power,console}; do
		mv "${D}"/usr/{s,}bin/${file} || die

		# The default install symlinks these commands to add a dash
		# after the ipmi prefix; we repeat those after move for
		# consistency.
		rm "${D}"/usr/sbin/${file/ipmi/ipmi-}
		dosym ${file} /usr/bin/${file/ipmi/ipmi-}
	done

	dodoc AUTHORS ChangeLog* DISCLAIMER* NEWS README* TODO doc/*.txt

	keepdir \
		/var/cache/ipmimonitoringsdrcache \
		/var/lib/freeipmi \
		/var/log/{freeipmi,ipmiconsole}

	newinitd "${FILESDIR}"/ipmidetectd.initd.2 ipmidetectd

	newinitd "${FILESDIR}"/bmc-watchdog.initd.2 bmc-watchdog
	newconfd "${FILESDIR}"/bmc-watchdog.confd bmc-watchdog
}
