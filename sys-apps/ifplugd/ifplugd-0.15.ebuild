# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ifplugd/ifplugd-0.15.ebuild,v 1.6 2004/07/15 01:47:49 agriffis Exp $

DESCRIPTION="Brings up/down ethernet ports automatically with cable detection"
HOMEPAGE="http://www.stud.uni-hamburg.de/users/lennart/projects/ifplugd"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"
DEPEND="dev-libs/libdaemon"

# Gentoo-provided scripts. Version is for the scripts, not ifplugd.
INITSCRIPT=${FILESDIR}/gentoo-ifplugd-init-v2
ACTIONSCRIPT=${FILESDIR}/gentoo-ifplugd.action-v2

src_unpack() {
	unpack ${A}

	cp ${ACTIONSCRIPT} ${T}/ifplugd.action
	cp ${INITSCRIPT} ${T}/ifplugd

	cd ${S}
	# This moves the default location for the script that handles
	# calling the distro network scripts to /usr/sbin. The reason
	# is that the user probably shouldn't mess with it.
	sed -i~ 's:SYSCONFDIR"/ifplugd/:"/usr/sbin/:' src/ifplugd.c
	# Remove the -w startup option; it gives an unwanted error return
	sed -i~ 's/ -w//' conf/ifplugd.conf
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	use doc && dohtml doc/*.html doc/*.css

	# Fix init.d configuration
	dodir /etc/conf.d
	cd ${D}/etc
	# rc config file
	mv ifplugd/ifplugd.conf conf.d/ifplugd
	rm -rf ifplugd/
	rm -f init.d/ifplugd

	dosbin ${T}/ifplugd.action

	exeinto /etc/init.d
	doexe ${T}/ifplugd
}
