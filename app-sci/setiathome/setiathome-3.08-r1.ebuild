# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/setiathome/setiathome-3.08-r1.ebuild,v 1.1 2003/05/04 13:36:48 aliz Exp $

IUSE="X"

S="${WORKDIR}/${P}"

# Don't know if this is necessary, will have to check the license
RESTRICT="nomirror"

# no version number on this install dir since upgrades will be using same dir
# (data will be stored here too)
I=/opt/setiathome

# 3.08 has not yet been released for ppc, sparc or alpha.

SRC_URI="x86? ( http://wcarchive.cdrom.com/pub/setiathome/setiathome-${PV}.i686-pc-linux-gnu.tar
		ftp://alien.ssl.berkeley.edu/pub/setiathome-${PV}.i686-pc-linux-gnu.tar )"
#	 ppc? ( http://wcarchive.cdrom.com/pub/setiathome/setiathome-${PV}.powerpc-unknown-linux-gnu.tar
#		ftp://alien.ssl.berkeley.edu/pub/setiathome-${PV}.powerpc-unknown-linux-gnu.tar )
#	 sparc? ( http://wcarchive.cdrom.com/pub/setiathome/setiathome-${PV}.sparc-unknown-linux-gnu.tar
#		  ftp://alien.ssl.berkeley.edu/pub/setiathome-${PV}.sparc-unknown-linux-gnu.tar )
#	 alpha? ( http://wcarchive.cdrom.com/pub/setiathome/setiathome-${PV}.alpha-unknown-linux-gnu.tar
#		  ftp://alien.ssl.berkeley.edu/pub/setiathome-3.03.alpha-unknown-linux-gnu.tar )"

DESCRIPTION="Search for Extraterrestrial Intelligence (SETI) @ home"
HOMEPAGE="http://setiathome.ssl.berkeley.edu"
DEPEND=">=sys-apps/baselayout-1.8.0"
RDEPEND="X? ( x11-base/xfree )"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 -ppc -sparc -alpha"

src_unpack () {
	cd ${WORKDIR}
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
	chown nobody.nogroup ${D}/${I}
	chown nobody.nogroup ${D}/${I}/setiathome
	chmod +s ${S}/setiathome

	exeinto /etc/init.d ; newexe ${FILESDIR}/seti-init.d-r1 setiathome
	insinto /etc/conf.d ; newins ${FILESDIR}/seti-conf.d-r1 setiathome
	echo "SETIATHOME_DIR=${I}">> ${D}/etc/conf.d/setiathome
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
