# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dxr2-driver/dxr2-driver-1.0.4.ebuild,v 1.2 2002/08/13 18:26:38 chouser Exp $

DESCRIPTION="Driver and minimal DVD player(s) for the Creative Labs Dxr2 Card"
HOMEPAGE="http://dxr2.sourceforge.net/"
SRC_URI="mirror://sourceforge/dxr2/${P}.tar.gz
	${HOMEPAGE}/projects/dxr2-driver/firmware/DVD12.UX"

LICENSE="GPL"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=media-libs/libdvdread-0.9.3"
#RDEPEND=""

# Non-standard source dir name for dxr2-driver
S=${WORKDIR}/${PN}

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
	mkdir -p ${D}/usr/bin ${D}/usr/lib ${D}/usr/src ${D}/etc/modules.d || die

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
	depmod -a
	ldconfig >/dev/null 2>&1
	/usr/sbin/update-modules || return 0
	einfo
	einfo "To load the dxr2 device automaticallly at boot time:"
	einfo "	echo dxr2 >> /etc/modules.autoload"
	einfo
}
