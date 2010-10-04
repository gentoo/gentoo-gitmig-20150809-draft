# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/freeipmi/freeipmi-0.8.9.ebuild,v 1.2 2010/10/04 12:21:24 hwoarang Exp $

EAPI=2

inherit autotools

DESCRIPTION="Provides Remote-Console and System Management Software as per IPMI v1.5/2.0"
HOMEPAGE="http://www.gnu.org/software/freeipmi/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	http://ftp.gluster.com/pub/${PN}/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug"

RDEPEND="dev-libs/libgcrypt"
DEPEND="${RDEPEND}
		virtual/os-headers"

src_prepare() {
	# Fix build mistake, only causes warnings but at least stop it.
	sed -i -e '/-module/d' "${S}"/libfreeipmi/src/Makefile.am || die

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
		--localstatedir=/var \
		--sysconfdir=/etc/freeipmi
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
	for file in ipmi{detect,ping,monitoring,power,console}; do
		mv "${D}"/usr/{s,}bin/${file} || die
	done

	# We try not to use /etc/ directly for all its config files,
	# instead use /etc/freeipmi, but then we got to move the
	# logrotate.d directory...
	mv "${D}"/etc/{freeipmi/,}logrotate.d || die

	dodoc AUTHORS ChangeLog* DISCLAIMER* NEWS README* TODO doc/*.txt || die

	keepdir \
		/var/cache/ipmimonitoringsdrcache \
		/var/lib/freeipmi \
		/var/log/{freeipmi,ipmiconsole}

	newinitd "${FILESDIR}/ipmidetectd.initd" ipmidetectd
	newinitd "${FILESDIR}/bmc-watchdog.initd" bmc-watchdog
	newconfd "${FILESDIR}/bmc-watchdog.confd" bmc-watchdog
}
