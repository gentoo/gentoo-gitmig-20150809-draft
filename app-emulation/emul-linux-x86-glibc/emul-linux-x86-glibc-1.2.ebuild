# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-glibc/emul-linux-x86-glibc-1.2.ebuild,v 1.1 2005/02/02 06:41:11 eradicator Exp $

IUSE="nptl nptlonly"

DESCRIPTION="GNU C Library for emulation of 32bit x86 on amd64"
HOMEPAGE="http://www.gentoo.org/"
BASE_URI="http://dev.gentoo.org/~eradicator/glibc"
SRC_URI="!nptl? ( ${BASE_URI}/${PN}-${PV}-lt.tar.bz2 )
	 nptl? ( !nptlonly? ( ${BASE_URI}/${PN}-${PV}-nptl.tar.bz2 ) )
	 nptl? ( nptlonly? ( ${BASE_URI}/${PN}-${PV}-nptlonly.tar.bz2 ) )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="!<app-emulation/emul-linux-x86-baselibs-1.2
	 ~sys-libs/glibc-2.3.4.20041102"

S=${WORKDIR}

src_install() {
	tar -c -f - . | tar -x -f - -C ${D}

	# create env.d entry
	mkdir -p ${D}/etc/env.d
	cat > ${D}/etc/env.d/40emul-linux-x86-glibc <<ENDOFENV
LDPATH=/emul/linux/x86/lib:/emul/linux/x86/usr/lib
ENDOFENV
	chmod 644 ${D}/etc/env.d/40emul-linux-x86-glibc
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
		run_verbose ln -sf /emul/linux/x86/usr/lib /usr/lib32
		echo "moving /usr/lib32-bork-bork-bork/* to /usr/lib32/"
		mv -v /usr/lib32-bork-bork-bork/* /usr/lib32/
		run_verbose rm -rf /usr/lib32-bork-bork-bork
		einfo "fixed!"
	fi
}
