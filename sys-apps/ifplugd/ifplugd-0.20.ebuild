# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ifplugd/ifplugd-0.20.ebuild,v 1.4 2004/07/15 01:47:49 agriffis Exp $

DESCRIPTION="Brings up/down ethernet ports automatically with cable detection"
HOMEPAGE="http://0pointer.de/lennart/projects/ifplugd/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="doc"
DEPEND=">=dev-libs/libdaemon-0.3
	doc? ( app-doc/doxygen net-www/lynx )"

# Gentoo-provided scripts. Version is for the scripts, not ifplugd.
INITSCRIPT=${FILESDIR}/gentoo-ifplugd-init-v3
ACTIONSCRIPT=${FILESDIR}/gentoo-ifplugd.action-v2
CONFFILE=${FILESDIR}/gentoo-ifplugd-conf-v3

src_unpack() {
	unpack ${A}

	cp ${INITSCRIPT} ${T}/ifplugd
	cp ${ACTIONSCRIPT} ${T}/ifplugd.action

	# This moves the default location for the script that handles
	# calling the distro network scripts to /usr/sbin. The reason
	# is that the user very probably shouldn't mess with it.
	cd ${S}
	sed -i~ 's:SYSCONFDIR"/ifplugd/:"/usr/sbin/:' src/ifplugd.c
}

src_compile() {
	local myconf

	# These are not needed for building
	myconf="--disable-xmltoman --disable-subversion"

	use doc \
		&& myconf="${myconf} --enable-doxygen --enable-lynx" \
		|| myconf="${myconf} --disable-doxygen --disable-lynx"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die

	# Fix init.d configuration
	cd ${D}/etc
	rm -rf ifplugd/
	rm -f init.d/ifplugd

	use doc && dohtml doc/*.html doc/*.css

	dodir /etc/conf.d
	cp ${CONFFILE} conf.d/ifplugd

	dosbin ${T}/ifplugd.action

	exeinto /etc/init.d
	doexe ${T}/ifplugd
}
