# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-driver/alsa-driver-0.9.0_rc1.ebuild,v 1.1 2002/04/27 08:04:55 agenkin Exp $

DESCRIPTION="Advanced Linux Sound Architecture kernel modules"
HOMEPAGE="http://www.alsa-project.org/"

# By default, drivers for all supported cards will be compiled.
# If you want to only compile for specific card(s), set ALSA_CARDS
# environment variable accordingly
[ x${ALSA_CARDS} = x ] && ALSA_CARDS=all

SRC_URI="ftp://ftp.alsa-project.org/pub/driver/${P/_rc/rc}.tar.bz2"
S=${WORKDIR}/${P/_rc/rc}

#virtual/glibc should depend on specific kernel headers
DEPEND="sys-devel/autoconf
        virtual/glibc"
PROVIDE="virtual/alsa"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--with-kernel="${ROOT}usr/src/linux-${KV}" \
		--with-isapnp=yes \
		--with-sequencer=yes \
		--with-oss=yes \
		--with-cards=${ALSA_CARDS} \
		|| die "./configure failed"
	
	emake || die "Parallel Make Failed"
}

src_install () {
	insinto /usr/include/sound
	cd ${S}/include
	doins *.h
	cd ${S}
	dodoc CARDS-STATUS COPYING FAQ INSTALL README WARNING TODO
	dodir /lib/modules/${KV}/misc
	cp ${S}/modules/*.o ${D}/lib/modules/${KV}/misc
	insinto /etc/modules.d
	doins ${FILESDIR}/alsa
	insinto /etc/init.d
	doins ${S}/utils/alsasound

}

pkg_postinst () {
	/usr/sbin/update-modules || return 0
}
