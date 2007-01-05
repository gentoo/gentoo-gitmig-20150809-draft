# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/icecream/icecream-0.6.20040829.ebuild,v 1.4 2007/01/05 22:06:55 dberkholz Exp $

inherit eutils
DESCRIPTION="Icecream is a program for distributed compiling of C(++) code across several machines based on ideas and code by distcc."
HOMEPAGE="http://en.opensuse.org/Icecream"
SRC_URI="ftp://ftp.suse.com/pub/projects/icecream/${PN}-0.6-20040829.tar.bz2
	mirror://gentoo/${PN}-${PV}.nokde.patch.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RDEPEND="virtual/libc
	kde? ( kde-base/kdelibs )"
DEPEND="${RDEPEND}"
IUSE="kde"

src_compile() {
	cd ${WORKDIR}/icecream
	epatch ${FILESDIR}/icecream_disable.patch || die "error patching icecream"

	if ! use kde ; then
		epatch $DISTDIR/${PN}-${PV}.nokde.patch.bz2 || die "error patching icecream"
	fi

	mv client/create-env client/create-env.orig
	sed -e 's/^LD_ASSUME_KERNEL/#LD_ASSUME_KERNEL/' -e 's/^export LD_ASSUME/#export LD_ASSUME/' client/create-env.orig >client/create-env || die "error patching create-env"
	mv configure.in configure.in.orig
	sed -e 's/^CFLAGS=/#CFLAGS=/' -e 's/^CXXFLAGS=/#CXXFLAGS=/' configure.in.orig >configure.in || die "error patching configure.in"

	use amd64 && export CFLAGS="${CFLAGS} -fPIC -DPIC"
	use amd64 && export CXXFLAGS="${CXXFLAGS} -fPIC -DPIC"
	./configure --prefix=/opt/icecream

	if use kde ; then
		emake || die "error compiling"
	else
		# I was too lazy to check how to replace KDE_CREATE_SUBDIRSLIST in configure.in
		cd minilzo; emake || die "error compiling"
		cd ../services; emake || die "error compiling"
		cd ../client; emake || die "error compiling"
		cd ../daemon; emake || die "error compiling"
	fi
}

src_install() {
	cd ${WORKDIR}/icecream
	if use kde ; then
		make DESTDIR=${D} install || die "error installing"
	else
		cd minilzo; make DESTDIR=${D} install || die "error installing"
		cd ../services; make DESTDIR=${D} install || die "error installing"
		cd ../client; make DESTDIR=${D} install || die "error installing"
		cd ../daemon; make DESTDIR=${D} install || die "error installing"
	fi
	mkdir -p ${D}etc/env.d
	# We are using kicecream to get it included after the kde-env
	# which ignores a previous KDEDIRS
	cp ${FILESDIR}/99icecream ${D}etc/env.d/99kicecream
	mkdir -p ${D}etc/init.d
	cp ${FILESDIR}/icecreamdaemon ${D}etc/init.d
	cp ${FILESDIR}/icecreamscheduler ${D}etc/init.d
}

pkg_postinst() {
	einfo "If you have compiled binutils/gcc/glibc with processor-specific flags"
	einfo "(as normal using Gentoo), there is a great chance that the chroot created"
	einfo "by icecc doesn't work with other machines. In that case it would be best"
	einfo "to install the appropriate icecream-chroot package."
	einfo "To use icecream with gentoo/ebuild use"
	einfo " PREROOTPATH=/opt/icecream/bin"
	einfo " (e.g. add this line in your /etc/make.conf)."
	einfo "To use it with normal make use"
	einfo ' PATH=/opt/icecream/bin:$PATH'
	einfo "Right now it doesn't work with ccache without some special work."
}
