# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/utempter/utempter-0.5.3.2.ebuild,v 1.1 2004/01/18 01:57:38 seemant Exp $

inherit rpm eutils

MY_P=${P%.*}-${PV##*.}
S=${WORKDIR}/${P%.*}
DESCRIPTION="App that allows non-privileged apps to write utmp (login) info, which needs root access"
# no homepage really, but redhat are the authors
HOMEPAGE="http://www.redhat.com"
SRC_URI="http://download.fedora.redhat.com/pub/fedora/linux/core/1/SRPMS/${MY_P}.src.rpm"

SLOT="0"
LICENSE="MIT | LGPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~amd64 ~ia64 ~ppc64"

RDEPEND="virtual/glibc"

pkg_setup() {
	enewgroup utmp 406
}

src_compile() {
	make RPM_OPT_FLAGS="${CFLAGS}" || die
}

src_install() {
	make RPM_BUILD_ROOT="${D}" install
	dobin utmp
	dodoc COPYING
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
