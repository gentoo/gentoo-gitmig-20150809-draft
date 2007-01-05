# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dxr2-driver/dxr2-driver-1.0.4.ebuild,v 1.11 2007/01/05 20:34:57 flameeyes Exp $

DESCRIPTION="Driver and minimal DVD player(s) for the Creative Labs Dxr2 Card"
HOMEPAGE="http://dxr2.sourceforge.net/"
SRC_URI="mirror://sourceforge/dxr2/${P}.tar.gz
	http://dxr2.sourceforge.net/projects/dxr2-driver/firmware/DVD12.UX"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-libs/libdvdread-0.9.3"

# Non-standard source dir name for dxr2-driver
S="${WORKDIR}/${PN}"

src_unpack() {
	# Don't try to unpack the last item -- should be the .UX firmware file
	unpack ${A% *}

	# Fix up the terrible makefile
	cd ${S}
	cp makefile makefile.orig
	sed -e 's:/usr/:$(DESTDIR)&:g' \
		-e 's:/lib/modules/:$(DESTDIR)&:g' \
		-e 's:/usr/local/:/usr/:g' \
		-e 's:ln -sf $(DESTDIR):ln -sf :' \
		-e 's:^.*modprobe:#&:' \
		-e 's:^.*depmod:#&:' \
		-e 's:^.*ldconfig:#&:' \
		makefile.orig > makefile || die

	# XXX: ought to fix up player/dxr2player.conf to make it gentoo-friendly
}

src_compile() {
	emake || die
}

src_install () {
	# make install doesn't create standard dirs -- do that now
	dodir /usr/bin /usr/lib /usr/src /etc/modules.d /dev

	# no devfs support in dxr2 yet?
	mknod ${D}/dev/dxr2 c 120 0 || die

	# copy in some files that aren't installed by make install
	cp player/dxr2player.conf ${D}/etc/ || die
	cp ${DISTDIR}/DVD12.UX ${D}/usr/src/dvd1.ux || die

	# build a default /etc/modules.d/dxr2
	echo 'alias char-major-120 dxr2' > ${D}/etc/modules.d/dxr2 || die

	# make install
	make DESTDIR=${D} install || die

	# dvdplay must be suid root
	chmod u+s ${D}/usr/bin/dvdplay || die
}

pkg_postinst() {
	if [[ ${ROOT} == / ]] ; then
		/sbin/modules-update
		depmod -a
		ldconfig >/dev/null 2>&1
	fi
	elog
	elog "To load the dxr2 device automaticallly at boot time:"
	elog "	echo dxr2 >> /etc/modules.autoload"
	elog
}
