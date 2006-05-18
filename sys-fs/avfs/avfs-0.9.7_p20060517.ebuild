# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/avfs/avfs-0.9.7_p20060517.ebuild,v 1.1 2006/05/18 19:16:31 genstef Exp $

inherit cvs

ECVS_SERVER="avf.cvs.sourceforge.net:/cvsroot/avf"
ECVS_MODULE="${PN}"
ECVS_CO_OPTS="-D ${PV: -8}"
ECVS_UP_OPTS="-dP ${ECVS_CO_OPTS}"

DESCRIPTION="AVFS is a virtual filesystem that allows browsing of compressed files."
HOMEPAGE="http://sourceforge.net/projects/avf"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
RDEPEND=">=sys-fs/fuse-2.4"
S=${WORKDIR}/${PN}

src_compile() {
	chmod 0755 autogen.sh
	./autogen.sh || die "Sorry, autogen.sh failed :("
	econf --enable-fuse || die "Sorry, can't configure :("
	emake || die "Sorry make failed :("
}

src_install() {
	# make install installs a lot of cruft, so install binary and
	# scripts manually
	dobin fuse/avfsd
	dobin scripts/mountavfs scripts/umountavfs

	# need library script wrappers to view additional filetypes that
	# are not compiled in.
	cd extfs
	# remove unnecessary files
	rm -rf *.in sfs.ini Makefile* CVS
	exeinto /usr/lib/avfs/extfs
	doexe *
	chmod 0644 ${D}/usr/lib/avfs/extfs/README ${D}/usr/lib/avfs/extfs/extfs.ini
	cd ..

	# install standard documentation, even though we are just
	# installing the fuse daemon
	cd doc
	dodoc api-overview background FORMAT INSTALL.* README.avfs-fuse
	cd ..
	dodoc AUTHORS ChangeLog COPYING* INSTALL NEWS README TODO

	# copy scripts, including mountavfs and umountavfs
	docinto scripts
	dodoc scripts/avfs* scripts/*pass scripts/*mountavfs
	# link README file in /usr/lib/avfs/extfs
	dosym /usr/lib/avfs/extfs/README /usr/share/doc/${PF}/README.extfs
}

pkg_postinst() {
	echo
	ewarn "***** THIS IS CVS CODE *****"
	ewarn "It may not work. YOU ARE WARNED!"
	echo
	einfo "This version of AVFS includes FUSE support. It is user-based."
	einfo "To execute:"
	einfo "1) as user, mkdir ~/.avfs"
	einfo "2) make sure fuse is either compiled into the kernel OR"
	einfo "   modprobe fuse or add to startup."
	einfo "3) run mountavfs"
	einfo "To unload daemon, type umountavfs"
	echo
	einfo "READ the documentation! Enjoy :)"
}
