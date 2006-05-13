# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/avfs/avfs-0.9.6_p20060301.ebuild,v 1.2 2006/05/13 04:46:25 dragonheart Exp $


inherit cvs

# this module is for pulling in AVFS CVS.
# this ebuild will only permit fuse functionality
# as avfs really does not work with coda or preloaded now.

# as this IS CVS, it is "use at your own risk!"
# and this ebuild is appropriately marked -*
# ebuild contributed by Peter Hyman (pete4abw@comcast.net), November 2005

# modified 3/2006 at suggestion of Stefan Schweizer to alter CVS fetch
# to be date sensitive for easier version tracking.

ECVS_SERVER="avf.cvs.sourceforge.net:/cvsroot/avf"
ECVS_MODULE="${PN}"
# Branch not needed
# ECVS_BRANCH="MAIN"
# extract date from version
ECVS_CO_OPTS="-D ${PV: -8}"
ECVS_UP_OPTS="-dP ${ECVS_CO_OPTS}"

DESCRIPTION="AVFS is a virtual filesystem that allows browsing of compressed files."
HOMEPAGE="http://sourceforge.net/projects/avf"

# mark all as testing
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

# Setting depend on current stable version of fuse.
DEPEND="sys-fs/fuse"

S=${WORKDIR}/${PN}
src_compile() {
	# set up
	# need to compile the whole shebang even though we just want 
	# the fuse part. Yuck!

	chmod 0755 autogen.sh
	./autogen.sh 	|| die "Sorry, autogen.sh failed :("
	econf --enable-library || die "Sorry, can't configure :("
	emake 			|| die "Sorry make failed :("

	# now chdir to fuse and run the provided compile script
	# I know this is ugly, and we probably should use CFLAGS
	# but for now, let's just get it done.

	einfo "Compiling fuse support..."
	cd fuse
	./compile.sh	|| die "Sorry, fuse module support compile failed :("

	# one file, avfsd, is created and needed!
}

src_install() {
	# install standard documentation, even though we are just
	# installing the fuse daemon
	cd doc
	dodoc api-overview background FORMAT INSTALL.* README.avfs-fuse
	cd ..
	dodoc AUTHORS ChangeLog COPYING* INSTALL NEWS README TODO

	# copy scripts, including mountavfs and umountavfs
	docinto scripts
	dodoc scripts/avfs* scripts/*pass scripts/*mountavfs

	# install our one file! Put it in /usr/bin so users can run.
	# also install our userland startup and shutdown scripts.
	dobin fuse/avfsd scripts/*mountavfs
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
