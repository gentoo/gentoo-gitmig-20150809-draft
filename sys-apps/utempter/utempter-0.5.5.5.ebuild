# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/utempter/utempter-0.5.5.5.ebuild,v 1.4 2004/07/24 17:27:27 geoman Exp $

inherit rpm eutils

MY_P=${P%.*}-${PV##*.}
S=${WORKDIR}/${P%.*}
DESCRIPTION="App that allows non-privileged apps to write utmp (login) info, which needs root access"
HOMEPAGE="http://www.redhat.com/"
SRC_URI="mirror://gentoo/${MY_P}.src.rpm
	http://dev.gentoo.org/~seemant/${MY_P}.src.rpm"

LICENSE="MIT | LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64"
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
	make RPM_OPT_FLAGS="${CFLAGS}" || die
}

src_install() {
	make \
		RPM_BUILD_ROOT="${D}" \
		LIBDIR=/usr/lib \
		install || die
	dobin utmp
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
