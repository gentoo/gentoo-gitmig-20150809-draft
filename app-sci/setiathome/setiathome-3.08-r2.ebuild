# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/setiathome/setiathome-3.08-r2.ebuild,v 1.3 2004/03/30 19:43:30 spyderous Exp $

# no version number on this install dir since upgrades will be using same dir
# (data will be stored here too)
I=/opt/setiathome

# 3.08 has not yet been released for ppc, sparc or alpha.
DESCRIPTION="Search for Extraterrestrial Intelligence (SETI) @ home"
HOMEPAGE="http://setiathome.ssl.berkeley.edu"
SRC_URI="x86? ( ftp://alien.ssl.berkeley.edu/pub/setiathome-${PV}.i686-pc-linux-gnu.tar )
	amd64? ( ftp://alien.ssl.berkeley.edu/pub/setiathome-${PV}.x86_64-pc-linux-gnu.tar )"
#	ppc? ( ftp://alien.ssl.berkeley.edu/pub/setiathome-${PV}.powerpc-unknown-linux-gnu.tar )
#	sparc? ( ftp://alien.ssl.berkeley.edu/pub/setiathome-${PV}.sparc-unknown-linux-gnu.tar )
#	alpha? ( ftp://alien.ssl.berkeley.edu/pub/setiathome-3.03.alpha-unknown-linux-gnu.tar )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="X"
# Don't know if this is necessary, will have to check the license
RESTRICT="nomirror"

DEPEND=">=sys-apps/baselayout-1.8.0"
RDEPEND="X? ( virtual/x11 )"

src_unpack () {
	unpack ${A}

	# find real directory ...
	dir="`find . -type d -name "${P}*" -mindepth 1 -maxdepth 1 | \
		cut -b "3-"`"
	# ... and rename it to our desired directory name
	mv "${dir}" "${P}"
}

src_install () {
	dodir ${I} /var/lib/setiathome
	cp {setiathome,README} ${D}/${I}
	use X && cp {xsetiathome,README.xsetiathome} ${D}/${I}
	chown nobody:nogroup ${D}/${I}
	chown nobody:nogroup ${D}/${I}/setiathome
	chmod +s ${S}/setiathome

	exeinto /etc/init.d ; newexe ${FILESDIR}/seti-init.d-r1 setiathome
	insinto /etc/conf.d ; newins ${FILESDIR}/seti-conf.d-r1 setiathome

	exeinto /var/lib/setiathome
	newexe ${FILESDIR}/setiathome-wrapper setiwrapper
}

pkg_postinst () {
	einfo "To run SETI@home in the background at boot:"
	einfo " Edit /etc/conf.d/setiathome to setup"
	einfo " Then just run \`/etc/init.d/setiathome start\`"
	einfo ""
	einfo "Otherwise remember to cd into the directory"
	einfo "where it should keep its data files first, like so:"
	einfo " cd /var/lib/setiathome && ${I}/setiathome"
	einfo ""
	einfo "As of 3.08-r1 data files has moved to /var/lib/setiathome"
}

pkg_postrm () {
	einfo "SETI@home data files were not removed."
	einfo " Remove them manually from /var/lib/setiathome"
}
