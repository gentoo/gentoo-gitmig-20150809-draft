# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/openmosix-user/openmosix-user-0.3.6-r3.ebuild,v 1.4 2006/04/25 22:22:09 voxus Exp $

inherit toolchain-funcs

OMRELEASE=2
S=${WORKDIR}/openmosix-tools-${PV}-${OMRELEASE}
DESCRIPTION="User-land utilities for openMosix process migration (clustering) software"
SRC_URI="mirror://sourceforge/openmosix/openmosix-tools-${PV}-${OMRELEASE}.tar.gz"
HOMEPAGE="http://www.openmosix.com/"
DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2
	>=sys-kernel/openmosix-sources-2.4.24"
RDEPEND="${DEPEND}
	sys-apps/findutils
	dev-lang/perl"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* x86"
IUSE=""

pkg_setup() {
	if ! [ -d /usr/src/linux/hpc ]; then
		eerror
		eerror "Your linux kernel sources do not appear to be openmosix,"
		eerror "please check your /usr/src/linux symlink."
		eerror
		die
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	cat > configuration << EOF

OPENMOSIX=/usr/src/linux
PROCDIR=/proc/hpc
MONNAME=mmon
CC=$(tc-getCC)
INSTALLDIR=/usr
CFLAGS=-I/m/include -I./ -I/usr/include -I\${OPENMOSIX}/include -I${S}/moslib ${CFLAGS}
INSTALL=/usr/bin/install
EOF

	# fix compile on gcc-3.4, because of goto labels
	sed -e "s|breakargv:|breakargv: ;|" -i ${S}/mps/mtop.c || die "failed to fix label stuff"
}

src_compile() {
	cd ${S}
	./configure --with-kerneldir=/usr/src/linux \
		    --mandir=${D}usr/share/man \
		    --sysconfdir=${D}/etc \
		    --bindir=${D}/bin \
		    --sbindir=${D}/sbin \
		    --libdir=${D}/usr/lib \
		    --with-sysvdir=${D}/etc/init.d \
		    --with-configdir=${D}/etc/openmosix \
		    --with-mapdir=${D}/etc \
		    --with-mosrundir=${D}/bin \
		    --prefix=${D}/usr || die "configure failed"
	emake || die "make failed"

	cd ${S}/mosrun
	for n in `echo cpujob fastdecay iojob nodecay nomig runhome slowdecay`; do
		sed -e "s:${D}::" -i $n;
	done
}

src_install() {
	dodir /bin
	dodir /sbin
	dodir /usr/share/doc
	dodir /usr/share/man/man1

	make install

	dodoc COPYING README
	rm ${D}/etc/init.d/openmosix
	exeinto /etc/init.d
	newexe ${FILESDIR}/openmosix.init openmosix
	insinto /etc
	rm ${D}/etc/openmosix.map
	#Test if mosix.map is present, stub appropriate openmosix.map
	#file
	if test -e /etc/openmosix.map; then
	    einfo "Seems you already have a openmosix.map file, using it.";
	elif test -e /etc/mosix.map; then
		cp /etc/mosix.map ${WORKDIR}/openmosix.map;
		doins ${WORKDIR}/openmosix.map;
	else
		doins ${FILESDIR}/openmosix.map;
	fi
}

pkg_postinst() {
	einfo
	einfo " To complete openMosix installation, edit /etc/openmosix.map or"
	einfo " delete it to use autodiscovery."
	einfo " Type:"
	einfo " # rc-update add openmosix default"
	einfo " to add openMosix to the default runlevel."
	einfo
}
