# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-ppc-glibc/emul-linux-ppc-glibc-2.3.4.20041102-r1.ebuild,v 1.1 2005/07/15 18:15:32 nigoro Exp $

IUSE="nptl nptlonly"

# Renamed 1.0 to 2.3.4.20041102-r1 so the version number was more descript,
# but use the old tarballs as they're still fine...
MY_PV=1.0

DESCRIPTION="GNU C Library for emulation of 32bit ppc on ppc64"
HOMEPAGE="http://www.gentoo.org/"
BASE_URI="http://dev.gentoo.org/~nigoro/ppc64/multilib/files"
SRC_URI="!nptl? ( ${BASE_URI}/${PN}-${MY_PV}-lt.tar.bz2 )
	 nptl? ( !nptlonly? ( ${BASE_URI}/${PN}-${MY_PV}-nptl.tar.bz2 ) )
	 nptl? ( nptlonly? ( ${BASE_URI}/${PN}-${MY_PV}-nptlonly.tar.bz2 ) )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~ppc64"

DEPEND=""
RDEPEND=">=sys-libs/glibc-${PV}"

S=${WORKDIR}

src_install() {
	tar -c -f - . | tar -x -f - -C ${D}

	# create env.d entry
	mkdir -p ${D}/etc/env.d
	cat > ${D}/etc/env.d/40emul-linux-ppc-glibc <<ENDOFENV
LDPATH=/emul/linux/ppc/lib:/emul/linux/ppc/usr/lib
ENDOFENV
	chmod 644 ${D}/etc/env.d/40emul-linux-ppc-glibc
}

run_verbose() {
	echo "running $@"
	$@ || die "unable to $@"
}

pkg_postinst() {
	# for some reason we have users with lib32 as a directory and not a symlink.
	# my guess is a broken version of opengl-update somewhere... but since
	# having lib32 as a directory is definately broken, lets fix that here.
	if [ ! -L /usr/lib32 ] ; then
		ewarn "/usr/lib32 is not a symlink... fixing"
		run_verbose mv /usr/lib32 /usr/lib32-bork-bork-bork
		run_verbose ln -sf /emul/linux/ppc/usr/lib /usr/lib32
		echo "moving /usr/lib32-bork-bork-bork/* to /usr/lib32/"
		mv -v /usr/lib32-bork-bork-bork/* /usr/lib32/
		run_verbose rm -rf /usr/lib32-bork-bork-bork
		einfo "fixed!"
	fi
}
