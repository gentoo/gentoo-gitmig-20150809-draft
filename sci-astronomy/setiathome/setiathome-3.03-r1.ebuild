# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/setiathome/setiathome-3.03-r1.ebuild,v 1.3 2005/08/23 15:23:24 fmccor Exp $

# no version number on this install dir since upgrades will be using same dir
# (data will be stored here too)
I=/opt/setiathome

DESCRIPTION="Search for Extraterrestrial Intelligence (SETI) @ home"
HOMEPAGE="http://setiathome.ssl.berkeley.edu"
SRC_URI="ppc? ( ftp://alien.ssl.berkeley.edu/pub/setiathome-${PV}.powerpc-unknown-linux-gnu.tar )
	sparc? ( ftp://alien.ssl.berkeley.edu/pub/setiathome-${PV}.sparc-unknown-linux-gnu.tar )
	ia64? ( ftp://alien.ssl.berkeley.edu/pub/setiathome-${PV}.ia64-Linux-gnu.tar )
	hppa? ( ftp://alien.ssl.berkeley.edu/pub/setiathome-${PV}.hppa-parisc-palinux.tar )"
#	alpha? ( ftp://alien.ssl.berkeley.edu/pub/setiathome-${PV}.alpha-unknown-linux-gnu.tar )

LICENSE="as-is"
SLOT="0"
KEYWORDS="ppc -alpha hppa ia64"
IUSE="X"
RESTRICT="nomirror"

DEPEND=">=sys-apps/baselayout-1.8.0"
RDEPEND="X? ( virtual/x11 )"

src_unpack () {
	unpack ${A}

	# find real directory ...
	dir="`find . -type d -name "${P}*" -mindepth 1 -maxdepth 1 | cut -b "3-"`"
	# ... and rename it to our desired directory name
	mv "${dir}" "${P}"
}

src_install () {
	insinto ${I}
	doins setiathome README
	use X && doins xsetiathome README.xsetiathome
	fowners nobody:nogroup ${I}
	fowners nobody:nogroup ${I}/setiathome
	fperms +sx ${I}/setiathome

	exeinto ${I}
	newexe ${FILESDIR}/setiathome-wrapper setiwrapper
	exeinto /etc/init.d ; newexe ${FILESDIR}/seti-init.d-r1 setiathome
	insinto /etc/conf.d ; newins ${FILESDIR}/seti-conf.d-r1 setiathome
	echo "SETIATHOME_DIR=${I}">> ${D}/etc/conf.d/setiathome
}

pkg_postinst() {
	einfo "To run SETI@home in the background at boot:"
	einfo " Edit /etc/conf.d/setiathome to setup"
	einfo " Then just run \`/etc/init.d/setiathome start\`"
	einfo ""
	einfo "Otherwise remember to cd into the directory"
	einfo "where it should keep its data files first, like so:"
	einfo " cd ${I} && ./setiathome"
}

pkg_postrm() {
	einfo "SETI@home data files were not removed."
	einfo " Remove them manually from ${I}"
}
