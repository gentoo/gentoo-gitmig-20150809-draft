# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/coreutils-darwin/coreutils-darwin-5.3.0.ebuild,v 1.7 2005/06/26 03:44:59 j4rg0n Exp $

inherit eutils

DESCRIPTION="Standard GNU file utilities, text utilities, and shell utilities missing from Darwin."
HOMEPAGE="http://www.gnu.org/software/coreutils/"
SRC_URI="mirror://gentoo/coreutils-5.3.0.tar.bz2
	http://meyering.free.fr/coreutils/coreutils-5.3.0.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc-macos"
IUSE="nls build static"
PROVIDES="virtual/coreutils"

DEPEND=">=sys-apps/portage-2.0.49
	sys-devel/automake
	sys-devel/autoconf
	sys-apps/help2man
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/coreutils-${PV}

# Existing utils

EXISTINGUSR="basename chgrp cksum comm cut dirname \
	du env expand false fmt fold groups head install id join \
	logname mkfifo nice nohup od paste pr printenv \
	printf sort split stat su sum tail tee touch tr true \
	tsort tty uname unexpand uniq uptime users wc who whoami yes"
EXISTINGBIN="cat chmod cp date dd df echo expr ln ls mkdir \
			 mv pwd rm rmdir sleep stty sync test"
EXISTINGUSBIN="chown chroot"
EXISTINGSBIN="mknod"
DONTLINK="[ kill hostname"
TENFOURBIN="link unlink csplit nl"
TENFOURUSBIN="pathchk readlink"

src_compile() {
	cd ${S}

	econf \
		--bindir=/bin \
		`use_enable nls` || die

	if use static; then
		append-ldflags -static
	fi
	emake || die
}

src_install() {

	# Install the utils
	cd ${S}
	make install infodir=${D}usr/share/info mandir=${D}usr/share/man bindir=${D}bin || die

	cd ${D}
	dodir /usr/bin
	rm -rf usr/lib

	cd ${D}/bin
	if [ "$MACOSX_DEPLOYMENT_TARGET" == "10.4" ]; then
		rm ${TENFOURBIN} ${TENFOURUSBIN}
	fi

	rm ${EXISTINGBIN} ${EXISTINGUSR} ${EXISTINGUSBIN} ${EXISTINGSBIN} ${DONTLINK}

	# Move the non-critical pacakges to /usr/bin
	if [ "$MACOSX_DEPLOYMENT_TARGET" != "10.4" ]; then
		mv csplit nl pathchk ${D}usr/bin
	fi
	mv factor md5sum pinky sha1sum tac ${D}usr/bin

	# Link binaries
	cd ${D}/usr/bin
	for BINS in `ls ${D}/bin` ; do
		dosym ../../bin/${BINS} /usr/bin/${BINS}
	done

	for BINS in ${EXISTINGUSR} ; do
		dosym /usr/bin/${BINS} /bin/${BINS}
	done

	for BINS in ${EXISTINGBIN} ; do
		dosym /bin/${BINS} /usr/bin/${BINS}
	done

	for BINS in ${EXISTINGUSBIN} ; do
		dosym /usr/sbin/${BINS} /bin/${BINS}
		dosym /usr/sbin/${BINS} /usr/bin/${BINS}
	done

	for BINS in ${EXISTINGSBIN} ; do
		dosym /sbin/${BINS} /bin/${BINS}
		dosym /sbin/${BINS} /usr/bin/${BINS}
	done

	# Remove the redundant man pages
	cd ${D}/usr/share/man/man1
	for BINS in ${EXISTINGBIN} ${EXISTINGUSR} ${EXISTINGUSBIN} ${EXISTINGSBIN} ${DONTLINK}; do
		if [ -f ${BINS}.1 ]; then
			rm ${BINS}.1
		fi
	done

	if [ "$MACOSX_DEPLOYMENT_TARGET" == "10.4" ]; then
		for BINS in ${TENFOURBIN} ${TENFOURUSBIN}; do
			if [ -f ${BINS}.1 ]; then
				rm ${BINS}.1
			fi
		done
	fi

	if ! use build
	then
		cd ${S}
		dodoc AUTHORS ChangeLog* NEWS README* THANKS TODO
	else
		rm -rf ${D}/usr/share
	fi
}

pkg_postrm() {
	# Unlink binaries
	for BINS in ${EXISTINGUSR} ; do
		rm /bin/${BINS}
	done

	for BINS in ${EXISTINGBIN} ; do
		rm /usr/bin/${BINS}
	done

	for BINS in ${EXISTINGUSBIN} ; do
		rm /bin/${BINS}
		rm /usr/bin/${BINS}
	done

	for BINS in ${EXISTINGSBIN} ; do
		rm /bin/${BINS}
		rm /usr/bin/${BINS}
	done
}
