# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/utempter/utempter-0.5.5.5-r1.ebuild,v 1.3 2005/03/31 16:04:28 kugelfang Exp $

inherit rpm eutils flag-o-matic

MY_P=${P%.*}-${PV##*.}
S=${WORKDIR}/${P%.*}
DESCRIPTION="App that allows non-privileged apps to write utmp (login) info, which needs root access"
HOMEPAGE="http://www.redhat.com/"
SRC_URI="mirror://gentoo/${MY_P}.src.rpm
	http://dev.gentoo.org/~seemant/${MY_P}.src.rpm"

LICENSE="|| ( MIT LGPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

RDEPEND="virtual/libc"

pkg_setup() {
	enewgroup utmp 406
}

src_unpack() {
	rpm_src_unpack
	cd ${S}
	epatch ${FILESDIR}/${P}-soname-makefile-fix.patch
}

src_compile() {
	append-ldflags -Wl,-z,now

	make RPM_OPT_FLAGS="${CFLAGS}" || die
}

src_install() {
	make \
		RPM_BUILD_ROOT="${D}" \
		LIBDIR=/usr/$(get_libdir) \
		install || die
	dobin utmp

	fowners root:utmp /usr/sbin/utempter
	fperms 2755 /usr/sbin/utempter
}


pkg_postinst() {
	if [ "${ROOT}" = "/" ]
	then
		if [ -f /var/log/wtmp ]
		then
			chown root:utmp /var/log/wtmp
			chmod 664 /var/log/wtmp
		fi

		if [ -f /var/run/utmp ]
		then
			chown root:utmp /var/run/utmp
			chmod 664 /var/run/utmp
		fi
	fi
}
