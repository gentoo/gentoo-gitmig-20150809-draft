# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/setiathome/setiathome-3.03-r1.ebuild,v 1.2 2002/07/19 20:52:43 rphillips Exp $

# generic archive name, this should be a link to the real archive
A="${P}.tar"

# this directory will not exist at first, we rename the real directory
# to this name later
S="${WORKDIR}/${P}"

# no version number on this install dir since upgrades will be using same dir
# (data will be stored here too)
I=/opt/setiathome

DESCRIPTION="Search for Extraterrestrial Intelligence (SETI) @ home"
HOMEPAGE="http://setiathome.ssl.berkeley.edu"
DEPEND=">=virtual/glibc-2.1
		>=sys-apps/baselayout-1.8.0"
RDEPEND=">=virtual/glibc-2.1
	X? ( x11-base/xfree )"
SLOT="0"
LICENSE="proprietary"

src_unpack () {
	if [ ! -e ${DISTDIR}/${A} ] ; then
		einfo "Please download the appropriate setiathome archive"
		einfo "for your system's architecture from:"
		einfo "http://setiathome.ssl.berkeley.edu/unix.html"
		einfo ""
		einfo "The archive should be placed into /usr/portage/distfiles."
		einfo "After that, create a symbolic link:"
		einfo ""
		einfo "\tln -s <archive> ${DISTDIR}/${A}"

		die "package archive not found"
	fi

	cd ${WORKDIR}
	tar xf ${DISTDIR}/${A}

	# find real directory ...
	dir="`find . -type d -name "${P}*" -mindepth 1 -maxdepth 1 | \
		cut -b "3-"`"
	# ... and rename it to our desired directory name
	mv "${dir}" "${P}"
}

src_install () {
	dodir ${I}
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
	einfo " cd ${I} && ./setiathome"
}

pkg_postrm () {
	einfo "SETI@home data files were not removed."
	einfo " Remove them manually from ${I}"
}
