# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openntpd/openntpd-3.9_p1-r2.ebuild,v 1.1 2009/10/14 08:04:18 bangert Exp $

EAPI="2"

inherit eutils

MY_P=${P/_/}
DESCRIPTION="Lightweight NTP server ported from OpenBSD"
HOMEPAGE="http://www.openntpd.org/"
SRC_URI="mirror://openbsd/OpenNTPD/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="ssl selinux"

RDEPEND="ssl? ( dev-libs/openssl )
	selinux? ( sec-policy/selinux-ntp )
	!<=net-misc/ntp-4.2.0-r2"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	enewgroup ntp 123
	enewuser ntp 123 -1 /var/lib/openntpd/chroot ntp

	#make sure user has correct HOME
	usermod -d /var/lib/openntpd/chroot ntp

	if has_version net-misc/ntp && ! built_with_use net-misc/ntp openntpd ; then
		die "you need to emerge ntp with USE=openntpd"
	fi
}

src_prepare() {
	sed -i '/NTPD_USER/s:_ntp:ntp:' ntpd.h || die
	epatch "${FILESDIR}"/openntpd-3.9p1_reconnect_on_sendto_EINVAL.diff
}

src_configure() {
	econf \
		--disable-strip \
		$(use_with !ssl builtin-arc4random) || die
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc ChangeLog CREDITS README

	newinitd "${FILESDIR}"/openntpd.rc-3.9_p1-r2 ntpd
	newconfd "${FILESDIR}"/openntpd.conf.d-3.9_p1-r2 ntpd

	dodir /var/lib/openntpd/chroot
}
