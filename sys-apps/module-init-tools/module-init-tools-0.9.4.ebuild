# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/module-init-tools/module-init-tools-0.9.4.ebuild,v 1.1 2002/12/19 09:40:37 lostlogic Exp $

# This includes backwards compatability for stable kernels

S="${WORKDIR}/${P}"
MODUTILS_PV=2.4.22
DESCRIPTION="Kernel module tools for the development kernel >=2.5.48"
SRC_URI="http://www.kernel.org/pub/linux/kernel/people/rusty/modules/${P}.tar.bz2
		http://www.kernel.org/pub/linux/utils/kernel/modutils/v2.4/modutils-${MODUTILS_PV}.tar.bz2"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/rusty/modules"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND="virtual/glibc"
RDEPEND=">=sys-kernel/development-sources-2.5.48"

src_compile() {
	einfo "Building modutils..."
	cd ${WORKDIR}/modutils-${MODUTILS_PV}

	econf \
		--disable-strip \
		--prefix=/ \
		--enable-insmod-static \
		--disable-zlib \
		${myconf}
	emake || die "emake modultils failed"

	einfo "Building module-init-tools..."
	cd ${S}

	econf \
		--prefix=/ \
		${myconf}

	emake || die "emake module-init-tools failed"
}

src_install () {

	cd ${WORKDIR}/modutils-${MODUTILS_PV}
	einstall prefix="${D}"
	dodoc COPYING CREDITS ChangeLog NEWS README TODO

	cd ${S}
	#this copies the old version of modutils to *.old so it still works
	#with kernels <= 2.4
	#This code was borrowed from the module-init-tools Makefile
	for f in lsmod modprobe rmmod depmod insmod; do
		if [ -L ${D}/sbin/${f} ]; then
			ln -sf `ls -l ${D}/sbin/${f} | \
				sed 's/.* -> //'`.old ${D}/sbin/${f};
		fi;
		mv ${D}/sbin/${f} ${D}/sbin/${f}.old;
	done
#	make prefix=${D} move-old-targets || die "Renaming old bins to *.old failed"

	einstall prefix=${D}

	#create the new modprobe.conf
	dodir /etc
	${S}/modules.conf2modprobe.conf /etc/modules.conf ${D}/etc/modprobe.conf || die "Could not create modprobe.conf"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO

	#install the modules.conf2modprobe.conf tool, so we can update modprobe.conf.
	into /usr
	dobin ${S}/modules.conf2modprobe.conf

}

pkg_postinst() {
        #Notify user of evilness, hope for a better way ;-)
	echo ""
 	einfo "This overwrites the modutils files, so if you remove this,"
 	einfo "remember to remerge modutils.  However, this package has"
 	einfo "installed a copy of the modutils files with suffix .old"
 	einfo "in your /sbin directory, which will automatically be used"
	einfo "when needed."
	echo ""
}



pkg_postrm() {
	if [ "$(best_version ${PN})" == "${CATEGORY}/${PF}" -a ! -f /sbin/insmod ]; then
		ewarn "Uninstalling module-init-tools has left you"
		ewarn "without a modutils installtion. we recommend"
		ewarn "emerging modutils immediately or remerging"
		ewarn "module-init-tools."
	fi
}

